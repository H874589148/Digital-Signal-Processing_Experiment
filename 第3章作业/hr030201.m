clear; close all;
fs = 10;
f1 = 50/512; f2 = 205/512;
a1 = 1; a2 = 2;
N = 512;
n = 0:N-1;
x = a1*sin(2*pi/fs*f1*n) + a2*sin(2*pi/fs*f2*n);

figure
[h1,w1]=freqz(x,1,'whole');
[h2,w2]=freqz(x);
subplot(211);plot(w1,abs(h1));
subplot(212);plot(w2,abs(h2));
