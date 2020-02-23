%--------------------------------------------------------------------------
% exa070903_remez_2.m,   for example 7.9.3 and 7.4.2;
% to test remez.m and to design multi-band FIR filter;
%-------------------------------------------------------------------------
clear all;

% 用切比雪夫最佳一致逼近设计线性相位多带FIR滤波器；
f=[0 .14 .18 .22 .26 .34 .38 .42 .46 .54 .58 .62 .66 1];
A=[1 1  0 0 1 1 0 0 1 1 0 0 1 1];
weigh=[8 1 8 1 8 1 8];	
b=remez(64,f,A,weigh);
%
[h,w]=freqz(b,1,256,1);
hr=abs(h);
h=abs(h);
h=20*log10(h);
figure(1)
stem(b,'.');grid;
figure(2)
plot(w,h);grid;

