clear all;
close all;
A = 2;
a=0.5;
f = 50;
fs = 400; % 采样率设置Hz
Ts=1/fs;
w = 2*pi*f*Ts;
n =0:300;
y = A.*exp(-a.*Ts.*n).*sin(w.*n);
subplot(211);stem(n,y,'.');
fs = 800; % 采样率设置改为 800Hz
Ts=1/fs;
w = 2*pi*f*Ts;
n =0:300;
y = A.*exp(-a.*Ts.*n).*sin(w.*n);
subplot(212);stem(n,y,'.');