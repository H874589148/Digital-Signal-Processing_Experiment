clear all;
close all;
f = 50;n =0:16;

fs = 100; % ����������100Hz
Ts=1/fs;
w = 2*pi*f*Ts;
y =sin(w.*n);
subplot(211);stem(n,y,'.');
fs = 150; % ���������ø�Ϊ 150Hz
Ts=1/fs;
w = 2*pi*f*Ts;
y =sin(w.*n);
subplot(212);stem(n,y,'.');