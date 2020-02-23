%--------------------------------------------------------------------------
% exa120801_cohere.m,  for example 12.8.1 
% to test cohere.m  ;
%-------------------------------------------------------------------------
clear all;

% 构造低通滤波系数b1和高通滤波序列b2
Fs=1;N=1024;
A=[1 1  0 0];
f=[0 .6 .7 1];
weigh=[1 10];	
b1=remez(42,f,A,weigh);

A=[0 0  1 1];
f=[0 .5 .7 1];
weigh=[10 1];	
b2=remez(42,f,A,weigh);

[h1,w]=freqz(b1,1,256,1);
h1=abs(h1);
h1=20*log10(h1);
subplot(331);plot(w,h1);grid;

[h2,w]=freqz(b2,1,256,1);
h2=abs(h2);
h2=20*log10(h2);
subplot(334);plot(w,h2);grid;

% 将高斯白噪通过两个滤波器
r=randn(16384,1);

x1=filter(b1,1,r);
x=x1(50:50+N);
[xpsd,F]=pwelch(x,N/4,1);
xpsd=10*log10(xpsd);
subplot(332);plot(F,xpsd);grid;

y1=filter(b2,1,r);
y=y1(50:50+N);
[ypsd,F]=pwelch(y,N/4,1);
ypsd=10*log10(ypsd);
subplot(335);plot(F,ypsd);grid;

% 估计 x和y 的相干函数；
[cxy,w]=cohere(x,y,N/4,Fs,hamming(N/4),0,'mean');
subplot(333);
plot(w,cxy);grid;

% 估计 x和y 的互功率谱；
[pxy,w]=csd(x,y,N/4,Fs,hamming(N/4),0,'mean');
pxy=20*log10(abs(pxy));
subplot(336);
plot(w,pxy);grid;

