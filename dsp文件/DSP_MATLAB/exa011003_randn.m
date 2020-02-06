%-----------------------------------------------------------------
% exa011003_randn, for example 1.10.3
% to test randn.m and to generate the white noise signal u(n) 
%                   with Gaussian distribution and power p
% 产生高斯分布的白噪信号，使功率为p，并观察数据分布的直方图
%-----------------------------------------------------------------
clear;

p=0.1;
N=500000;
u=randn(1,N);
a=sqrt(p)
u=u*a; 
power_u=var(u)
subplot(211)
plot(u(1:200));grid on;
ylabel('u(n)');
xlabel('n')     
subplot(212)
hist(u,50);grid on; 
ylabel('histogram of u(n)');     


