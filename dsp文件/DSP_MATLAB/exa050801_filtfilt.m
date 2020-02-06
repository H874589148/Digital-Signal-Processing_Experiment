% ------------------------------------------------------------------------------
% exa050801_filtfilt.m, for example 5.8.1;
% to test filtfilt.m and to realize the zero-phase filtering;
% ------------------------------------------------------------------------------
clear;

N=32;
n=-N/2:N+N/2;
w=0.1*pi;
x=cos(w*n)+cos(2*w*n);
subplot(311);stem(n,x,'.');grid on;
xlabel('n');

% 用下面给定的系统（b,a）对信号 x 作零相位滤波；
b=[0.06745 0.1349 0.06745];
a=[1 -1.143 0.4128];
y=filtfilt(b,a,x);
subplot(312);stem(n,y,'.');grid on;
xlabel('n');

