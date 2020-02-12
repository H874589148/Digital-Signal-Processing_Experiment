#include<stdio.h>
#include<math.h>
#include<stdlib.h> 
#define length 180		/*����֡��Ϊ180��=22.5ms@8kHz����*/
#define filterlen 19
#define flag 0
/*19���˲���ϵ��*/
static float h[filterlen]={	0.01218354,-0.009012882,-0.02881839,-0.04743239,-0.04584568,-0.008692503,0.06446265,0.1544655,0.2289794,0.257883,0.2289794,0.1544655,0.06446265,-0.008692503,-0.04584568,-0.04743239,-0.02881839,-0.009012882,0.01218354} ;//19���˲���ϵ��
static short x1[length+filterlen-1];
static long long int temph[filterlen];
 

/*��ͨ�˲������ӳ���*/
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
		sum=tempsum/32768;			//����2��15�η�
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
	for(i=0;i<filterlen;i++)	temph[i]=h[i]*32768;	//����2��15�η�	
	fp1=fopen("bluesky1.wav","r+b");	//���������ļ�
	fp2=fopen("outdata.wav","w+b");		//�˲��������ļ�
	fseek(fp1,44,SEEK_SET);
	while(length==fread(indata,2,length,fp1))
	{
		fpend=ftell(fp1);		//��ȡ��ǰ�ļ�ָ�� 
		frame++;
		printf("frame=%d:",frame);
		for(j=0;j<length;j++)	printf("%d, ",indata[j]);
		printf("\n");	
		filter(indata,outdata,filterlen,temph);		//���õ�ͨ�˲��ӳ���
		if(flag==fseek(fp2,fpstart,SEEK_SET))
		{
			/*�ж��������趨д���ļ��ķ�ʽ��180��2�ֽ���*/ 
			if(length==fwrite(outdata,2,length,fp2))
			{
				fseek(fp2,fpend,SEEK_SET);			//���õ�ǰ�������ָ�� 
				fpstart=fpend;					//���ƴ���ָ�룬��һ��180�� 
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
	fclose(fp1);		//�ر��ļ�
	fclose(fp2);
	return(0); 
} 

