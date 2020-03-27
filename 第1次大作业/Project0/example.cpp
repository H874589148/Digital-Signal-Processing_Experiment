#include<stdio.h>
#define _GNU_SOURCE
const int length = 180 ;         /*语音帧长为180点=22.5ms@8kHz采样*/

void filter(int xin[], int xout[], int n, float h[]);    /*滤波子程序说明*/
/*19点滤波器系数*/
static float h[19]=
	{0.01218354,-0.009012882,-0.02881839,-0.04743239,-0.04584568,
	-0.008692503,0.06446265,0.1544655,0.2289794,0.257883,
	0.2289794,0.1544655,0.06446265,-0.008692503,-0.04584568,
	-0.04743239,-0.02881839,-0.009012882,0.01218354};
	
static int x1[length+20];
/*低通滤波浮点子程序*/
void filter(int xin[],int xout[],int n,float h[])
	{
		int i,j;
		float sum;
		for(i=0;i<length;i++) x1[n+i-1]=xin[i];
		for(i=0;i<length;i++)
		{
			sum=0.0;
			for(j=0;j<n;j++) sum+=h[j]*x1[i-j+n-1];
			xout[i]=(int)sum;
		}
		for(i=0;i<(n-1);i++) x1[n-i-2]=xin[length-1-i];
	}
	
/*主程序*/
int main()
{
	FILE *fp1,*fp2;
	int i;
	int frame,indata[length],outdata[length];
	fp1=fopen("bluesky1.wav","rb");                   /*输入语音文件*/
	fp2=fopen("output.txt","wb");                  /*滤波后语音文件*/
	
	frame=0;
	while(feof(fp1)==0)
	{
		frame++;
		printf("frame=%d\n",frame);
		for(i=0;i<length;i++) indata[i]=fread(fp1);      /*取一帧语音数据*/
		filter(indata,outdata,19,h);                    /*调用低通滤波子程序*/
		for(i=0;i<length;i++) fwrite(outdata[i],fp2);     /*将滤波后的样值写入文件*/ 
	}
	fclose(fp1);
	fclose(fp2);                                        /*关闭文件*/
	return(0); 
}


