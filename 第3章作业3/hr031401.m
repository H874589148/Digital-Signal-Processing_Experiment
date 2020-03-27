clear all;
close all;
f = 50;n =0:16;

fs = 100; % 采样率设置100Hz
Ts=1/fs;
w = 2*pi*f*Ts;
y =sin(w.*n);
subplot(211);stem(n,y,'.');
fs = 150; % 采样率设置改为 150Hz
Ts=1/fs;
w = 2*pi*f*Ts;
y =sin(w.*n);
subplot(212);stem(n,y,'.');