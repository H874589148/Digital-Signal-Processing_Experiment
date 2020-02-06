%--------------------------------------------------------------------------
% exa070803_remez_1.m,   for example 7.8.3 and 7.4.1;
% to test remez.m and to design Low-pass FIR filter;
%-------------------------------------------------------------------------
clear all;

f=[0 .6 .7 1];
% 给定频率轴分点；
A=[1 1  0 0];
% 给定在这些频率分点上理想的幅频响应；
weigh=[1 10];	
% 给定在这些频率分点上的加权；

b=remez(32,f,A,weigh);
% 设计出切比雪夫最佳一致逼近滤波器；
%
[h,w]=freqz(b,1,256,1);
h=abs(h);
h=20*log10(h);
figure(1)
stem(b,'.');grid;
figure(2)
plot(w,h);grid;
  