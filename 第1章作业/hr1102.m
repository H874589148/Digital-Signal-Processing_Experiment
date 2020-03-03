clear all;
close all;
A = 2;
a=0.5;
f = 2;
fs = 16; % ����������Hz
Ts=1/fs;
w = 2*pi*f*Ts;
n =0:80;
y = A.*exp(-a.*Ts.*n).*sin(w.*n);
subplot(211);stem(n,y,'.');
fs = 32; % ���������ø�Ϊ 800Hz
Ts=1/fs;
w = 2*pi*f*Ts;
n =0:80;
y = A.*exp(-a.*Ts.*n).*sin(w.*n);
subplot(212);stem(n,y,'.');