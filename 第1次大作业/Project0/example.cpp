#include<stdio.h>
#define _GNU_SOURCE
const int length = 180 ;         /*����֡��Ϊ180��=22.5ms@8kHz����*/

void filter(int xin[], int xout[], int n, float h[]);    /*�˲��ӳ���˵��*/
/*19���˲���ϵ��*/
static float h[19]=
	{0.01218354,-0.009012882,-0.02881839,-0.04743239,-0.04584568,
	-0.008692503,0.06446265,0.1544655,0.2289794,0.257883,
	0.2289794,0.1544655,0.06446265,-0.008692503,-0.04584568,
	-0.04743239,-0.02881839,-0.009012882,0.01218354};
	
static int x1[length+20];
/*��ͨ�˲������ӳ���*/
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
	
/*������*/
int main()
{
	FILE *fp1,*fp2;
	int i;
	int frame,indata[length],outdata[length];
	fp1=fopen("bluesky1.wav","rb");                   /*���������ļ�*/
	fp2=fopen("output.txt","wb");                  /*�˲��������ļ�*/
	
	frame=0;
	while(feof(fp1)==0)
	{
		frame++;
		printf("frame=%d\n",frame);
		for(i=0;i<length;i++) indata[i]=fread(fp1);      /*ȡһ֡��������*/
		filter(indata,outdata,19,h);                    /*���õ�ͨ�˲��ӳ���*/
		for(i=0;i<length;i++) fwrite(outdata[i],fp2);     /*���˲������ֵд���ļ�*/ 
	}
	fclose(fp1);
	fclose(fp2);                                        /*�ر��ļ�*/
	return(0); 
}


