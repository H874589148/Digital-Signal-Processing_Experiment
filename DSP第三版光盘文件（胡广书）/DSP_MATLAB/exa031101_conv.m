%----------------------------------------------------------------------------
% exa031101_conv.m, for example 3.11.1
% 
% ��ʹ�á�fftfilt"�ļ����Լ����ʵ��һ�������к�һ�������еľ����
%----------------------------------------------------------------------------
clear;

% �����˲���ϵ��h�ͻ��и�˹����������ź�x
h=fir1(10,0.3,hanning(11));
N=500;p=0.05;f=1/16;
u=randn(1,N)*sqrt(p);%
s=sin(2*pi*f*[0:N-1]);
x=u(1:N)+s;

% ��x��Ϊ����ΪL��С��
L=20;M=length(h);
y=zeros(1,N+M-1);
tempy=zeros(1,M+L-1);
tempX=zeros(1,L);
for k=0:N/L-1
   tempx(1:L)=x(k*L+1:(k+1)*L);
   tempy=conv(tempx,h);
   y=y+[zeros(1,k*L),tempy,zeros(1,N-(k+1)*L)];
end

subplot(211);plot(x)
subplot(212);plot(y(1:N))