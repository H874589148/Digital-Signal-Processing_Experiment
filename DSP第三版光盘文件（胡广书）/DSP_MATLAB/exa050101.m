%---------------------------------------------------------------------------
% exa050101.m  for example 5.1.1 
% to explain the linear phase;
%---------------------------------------------------------------------------
clear all;

% 产生信号；
N=16;
n=-N/2:N+N/2;
w=0.1*pi;
x=cos(w*n)+cos(2*w*n);
subplot(311)
stem(n,x,'.');grid on;
hold on;
plot(n,zeros(size(x)));

% 线性相移；
x=cos(w*(n-3))+cos(2*w*(n-3));
subplot(312)
stem(n,x,'.');grid on;
hold on;
plot(n,zeros(size(x)));

% 非线性相移；
x=cos(w*n-pi/4)+cos(2*w*n-pi);
subplot(313)
stem(n,x,'.');grid on;
hold on;
plot(n,zeros(size(x)));

