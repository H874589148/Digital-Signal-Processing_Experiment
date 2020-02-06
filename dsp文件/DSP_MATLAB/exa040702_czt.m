%-----------------------------------------------------------------
%  exa040702_czt.m,   for example 4.7.2
%  to test czt.m     
%-----------------------------------------------------------------
clear all��

% ����������ͬƵ�ʵ������źŵĵ�����Ϊ�����ź�
N=128;
f1=8;f2=8.22;f3=9;fs=40;
stepf=fs/N;
n=0:N-1;
t=2*pi*n/fs;
n1=0:stepf:fs/2-stepf;
x=sin(f1*t)+sin(f2*t)+sin(f3*t);
M=N;
W=exp(-j*2*pi/M);

% A=1ʱ��czt�任
A=1;
Y1=czt(x,M,W,A);
subplot(311)
plot(n1,abs(Y1(1:N/2)));grid on;

% DTFT
Y2=abs(fft(x));
subplot(312)
plot(n1,abs(Y2(1:N/2)));grid on;

% ��ϸ����A���czt 
M=60;
f0=7.2;
DELf=0.05;
A=exp(j*2*pi*f0/fs);
W=exp(-j*2*pi*DELf/fs);
Y3=czt(x,M,W,A);
n2=f0:DELf:f0+(M-1)*DELf;
subplot(313);plot(n2,abs(Y3));grid on;