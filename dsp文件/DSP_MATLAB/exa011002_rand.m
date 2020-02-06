%-----------------------------------------------------------------
% exa011002_rand  for example 1.10.2
% to generate the white noise signal u(n)  with uniform distribution
%                                               and power p;
% 产生均匀分布的白噪信号，使均值为0，功率为p
%-----------------------------------------------------------------
clear;

p=0.01;
N=50000;
u=rand(1,N);
u=u-mean(u);
a=sqrt(12*p); 
u1=u*a;
power_u1=dot(u1,u1)/N  
subplot(211)
plot(u1(1:200));grid on;
ylabel('u(n)')     
xlabel('n')     

