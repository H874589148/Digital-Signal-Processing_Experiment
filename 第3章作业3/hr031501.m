clear all;close all;
fs=200; f0=50;
N=16;
n=0:N-1;
x=[sin(2*pi*f0*n/fs) zeros(1,N)]; X=fft(x,N+N);
k=0:2*N-1;
subplot(211);
stem(k,abs(X));xlabel('x(n)');ylabel('X(k)');
title('≤π¡„');


x3=sin(2*pi*f0*n/fs); X3=fft(x3,N);
subplot(212);
stem(n,abs(X3));xlabel('x(n)');ylabel('X(k)');
title('≤ª≤π¡„');
