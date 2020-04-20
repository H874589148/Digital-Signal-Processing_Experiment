typedef unsigned char uchar;
typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned long uint32;
typedef char sint8;
typedef short sint16;
typedef long sint32;
typedef float fp32;
typedef double fp64;
#include <stdio.h>
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

int main()
{
    FILE *fp1,*fp2,*fp3;
	int i,frame,data[length-22],ftdata[length-22],indata[length],outdata[length];
	fopen_s(&fp1,"bluesky1.wav","rb");                     /*���������ļ�*/
	fopen_s(&fp2,"bluesky1.txt","wb");                     /*��ȡ�����ļ�*/
	fopen_s(&fp3,"blueskyft.wav","wb");                     /*��������ļ�*/
    //char list[30];
    // ���ļ�
    frame=0;
    if( fp1 != NULL )                                       // �ļ���ȡ
    {
        while(feof(fp1)==0)
		{
			frame++;
			printf("\n\nframe=%d : \n",frame);
			fprintf(fp2,"\n\n\n\nframe=%d : \n",frame);
			for(i=0;i<length;i++){
				//fread(data+i,sizeof(sint16),1,fp1);           /*ȡһ֡��������*/
				fread(indata+i,sizeof(sint16),1,fp1);           /*ȡһ֡��������*/
				fprintf(fp2,"%d\t",indata[i]);
				//putw(data[i],fp2);
				//fwrite(data+i,sizeof(sint16),1,fp2);         /*���˲������ֵд���ļ�*/
			}
			for(i=0;i<length;i++){
				printf("%d\t",indata[i]);
			}
			while(frame==1){
				for(i=22;i<length;i++){
					data[i-22]=indata[i];                       //������������
				}
				filter(data,ftdata,19,h);                       //���õ�ͨ�˲��ӳ���
				for(i=0;i<22;i++){
					outdata[i]=indata[i];
				}
				for(i=22;i<length;i++){
					outdata[i]=ftdata[i-22];
				}
			}
			while (frame != 1) {
				for (i = 0; i < length; i++) {
					filter(indata, ftdata, 19, h);                       //���õ�ͨ�˲��ӳ���
					outdata[i] = ftdata[i];
				}
			}
			for(i=0;i<length;i++){
				//fprintf(fp3,"%d",indata[i]);
				//putw(indata[i],fp3);
				fwrite(outdata+i,sizeof(sint16),1,fp3);        //дһ֡��������
			}
		}
    }
    else
    {
        printf( "File could not be opened\n" );
    }
	/*fclose(fp1);
	fclose(fp2);
	fclose(fp3);�ر��ļ�*/
	_fcloseall();
	
	return(0);    
}
