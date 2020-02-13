
#include <fract.h>
#include <filter.h>
#include <sys_init.h>

/* FIR数据长度 			*/
#define VEC_SIZE 32000
/* FIR滤波器H参数个数 	*/
#define NUM_TAPS 19
const  int length = 180;  /*语音帧长 为180点= 22.5ms@ 8kHz采样*/
/* FIR滤波输入数据 		*/
short int in[VEC_SIZE] = {0};


/* FIR滤波H参数 		*/
short int  coefs[NUM_TAPS] =
{
0x018f,0xfed9,0xfc50,0xf9ee,0xfa22,0xfee4,0x0840,0x13c5,0x1d4f,0x2102,0x1d4f,0x13c5,0x0840,0xfee4,0xfa22,0xf9ee,0xfc50,0xfed9,0x018f
};

fract16 delay[NUM_TAPS];

/* FIR滤波输出数据 		*/
short int out[VEC_SIZE + NUM_TAPS - 1];

/* FIR滤波器状态变量 	*/
fir_state_fr16 state;
static short int x1[200]={0}; 
void filter(short int xin[], short int xout[], int n, short int h[])
{

int i, j;
short int sum;
for (i = 0; i < length; i ++) x1[n + i - 1] = xin[i];
for (i = 0; i < length; i++)
{
	sum = 0;
	for (j = 0; j < n; j++) sum += h[j]/32768.0 * x1[i - j + n - 1];
	xout[i] = sum;
}
for (i = 0; i < (n - 1); i++)
	x1[n - i - 2] = xin[length - 1 - i];

}
/********************************************************
*
*	函数名        : main
*	函数功能      : main函数
*	函数输入参数  : 
*	函数输出      : 
*	说明          :  
*
********************************************************/
void main(void) {
	Init_PLL();
	Init_EBIU();
	Init_SDRAM();
	/* FIR滤波初始化 	*/
	fir_init(state, coefs, delay, NUM_TAPS, 1);
	int frame;
	
	/* FIR滤波 			*/
for(frame=0;frame<=177;frame++)
	{
		 printf("%d\n",frame);
		//in.seekg(frame * 2*length );
	
		filter(in+frame*180, out+frame*180 ,NUM_TAPS, coefs);
	}
	while (1) {
	    printf("ok\n");
	}
}

