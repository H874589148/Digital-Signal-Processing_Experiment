%-------------------------------------------------------------------------------
% exa070801_fir1.m , for example 7.8.1 and 7.1.1
% to test fir1.m,
%-------------------------------------------------------------------------------
clear all;

N=10;
b1=fir1(N,0.25,boxcar(N+1));    % 用矩形窗作为冲激响应的窗函数
b2=fir1(N,0.25,hamming(N+1));   % 用Hamming窗作为冲激响应的窗函数
%
M=128;
h1=freqz(b1,1,M);
h2=freqz(b2,1,M);
% 分别求两个滤波器的频率响应；
t=0:10;
subplot(221)
stem(t,b2,'.');hold on;
plot(t,zeros(1,11));grid;
%
f=0:0.5/M:0.5-0.5/M;
M1=M/4;
for k=1:M1
   hd(k)=1;
   hd(k+M1)=0;
   hd(k+2*M1)=0;
   hd(k+3*M1)=0;
end
subplot(222)
plot(f,abs(h1),'b-',f,abs(h2),'g-',f,hd,'-');grid;