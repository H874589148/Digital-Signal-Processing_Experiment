%----------------------------------------------------------------------------
% exa031102_hilbert.m, for example 3.11.2
% to test hilbert.m,and to find the Hilbert transform of signal x(n)
%----------------------------------------------------------------------------
clear all;

N=25;
f=1/16;
x=sin(2*pi*f*[0:N-1]);
y=hilbert(x);
% 求 x 的希尔伯特变换；

subplot(221)
stem(x,'.');
hold on;
plot(zeros(size(x)));
subplot(222)
stem(imag(y),'.');        
% imag(y) is the Hilbert transform of x(n);
hold on;
plot(zeros(size(x)));

