typedef short sint16;
#include <stdio.h>
#include <iostream>
using namespace std;
const int length = 180;         /*语音帧长为180点=22.5ms@8kHz采样*/

void filter(short xin[], short xout[], short n, int h[]);    /*滤波子程序说明*/
/*19点滤波器系数*/
static int h_fixed[19] = { 798,-590,-1888, -3108,-3004,
-569,4224,10123,15006,16900,
15006,10123,4224,-569,-3004,
-3108,-1888,-590,798 };
/*
static float h[19] =
{ 0.01218354,-0.009012882,-0.02881839,-0.04743239,-0.04584568,
-0.008692503,0.06446265,0.1544655,0.2289794,0.257883,
0.2289794,0.1544655,0.06446265,-0.008692503,-0.04584568,
-0.04743239,-0.02881839,-0.009012882,0.01218354 };
*/

static int x1[length + 20];
/*低通滤波浮点子程序*/
void filter(short xin[], short xout[], short n, int h[])
{
	int i, j;
	int sum;
	for (i = 0; i < length; i++) x1[n + i - 1] = xin[i];
	for (i = 0; i < length; i++)
	{
		sum = 0;
		for (j = 0; j < n; j++) sum += h[j] * x1[i - j + n - 1];
		xout[i] = (short)(sum>>16);
	}
	for (i = 0; i < (n - 1); i++) x1[n - i - 2] = xin[length - 1 - i];
}

int main() {
	FILE *fp1, *fp2,*fp3;
	sint16 frame, i;
	sint16 ftdata[length] = { 0 };
	sint16 outdata[length + 22] = { 0 };
	sint16 indata[length] = { 0 };
	sint16 data[length] = { 0 };
	fopen_s(&fp1, "bluesky1.wav", "rb");
	fopen_s(&fp2, "bluesky1.txt", "wb");
	fopen_s(&fp3, "blueskyft.wav", "wb");
	if (NULL == fp1) {
		printf("error");
		return 0;
	}
	frame = 0;
	while (!feof(fp1)) {
		frame++;
		printf("\nframe=%d : \n", frame);
		fprintf(fp2, "\n\n\n\nframe=%d : \n", frame);
		for (i = 0; i < length; i++) {
			fread(indata + i, sizeof(sint16), 1, fp1);
			cout << indata[i] << " ";
			fprintf(fp2, "%d\t", indata[i]);         /*将滤波后的样值写入文件*/
		}
		cout << "\n";
		sint16 counter = 0;
		if (frame == 1) {
			for (i = 22; i < length; i++) {
				data[counter++] = indata[i];
			}
			filter(data, ftdata, 19, h_fixed);
			for (i = 0; i < length + 22; i++) {
				if (i < 22)
					outdata[i] = indata[i];
				else
					outdata[i] = ftdata[i - 22];
			}
			for (i = 0; i < length; i++) {
				fwrite(outdata + i, sizeof(sint16), 1, fp3);
			}
		}
		else {
			filter(indata, ftdata, 19, h_fixed);
			for (i = 0; i < length; i++) {
				fwrite(ftdata + i, sizeof(sint16), 1, fp3);
			}
		}
	}
	_fcloseall();
	printf("victory!!!");
	return 0;
}
