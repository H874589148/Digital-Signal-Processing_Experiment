#include<stdio.h>
#include<math.h>
#include<stdlib.h> 
#define length 180		/*语音帧长为180点=22.5ms@8kHz采样*/
#define filterlen 19
#define flag 0
/*19点滤波器系数*/
static float h[filterlen]={	0.01218354,-0.009012882,-0.02881839,-0.04743239,-0.04584568,-0.008692503,0.06446265,0.1544655,0.2289794,0.257883,0.2289794,0.1544655,0.06446265,-0.008692503,-0.04584568,-0.04743239,-0.02881839,-0.009012882,0.01218354} ;//19点滤波器系数
static short x1[length+filterlen-1];
static long long int temph[filterlen];
 

/*低通滤波定点子程序*/
void filter(short xin[],short xout[],int n,long long int temph[]) 
{
	int i,j;
	float sum=0.0;
	long long int tempsum;
	for(i=0;i<length;i++)x1[n+i-1]=xin[i];
	for(i=0;i<length;i++)
	{
		tempsum=0;
		for(j=0;j<n;j++)tempsum+=temph[j]*x1[i-j+n-1];
		sum=tempsum/32768;			//除以2的15次方
		xout[i]=(short)sum;
	}
	for(i=0;i<(n-1);i++)x1[n-i-2]=xin[length-1-i];
} 

int main()
{
	int i,j;
	int fpstart=44,fpend;
	FILE *fp1=0,*fp2=0;
	int frame=0;
	short indata[length],indata1[length],indata2[length],outdata[length];
	for(i=0;i<filterlen;i++)	temph[i]=h[i]*32768;	//乘以2的15次方	
	fp1=fopen("bluesky1.wav","r+b");	//输入语音文件
	fp2=fopen("outdata.wav","w+b");		//滤波后语音文件
	fseek(fp1,44,SEEK_SET);
	while(length==fread(indata,2,length,fp1))
	{
		fpend=ftell(fp1);		//获取当前文件指针 
		frame++;
		printf("frame=%d:",frame);
		for(j=0;j<length;j++)	printf("%d, ",indata[j]);
		printf("\n");	
		filter(indata,outdata,filterlen,temph);		//调用低通滤波子程序
		if(flag==fseek(fp2,fpstart,SEEK_SET))
		{
			/*判定条件：设定写入文件的方式，180项2字节数*/ 
			if(length==fwrite(outdata,2,length,fp2))
			{
				fseek(fp2,fpend,SEEK_SET);			//设置当前处理完的指针 
				fpstart=fpend;					//后移处理指针，下一个180项 
			}
		}
		else
		{
			printf("fail\n");
			break; 
		}
		if(frame>4000)
		{
			printf("data overflow\n");
			break;
		}
	}
	fclose(fp1);		//关闭文件
	fclose(fp2);
	return(0); 
} 

