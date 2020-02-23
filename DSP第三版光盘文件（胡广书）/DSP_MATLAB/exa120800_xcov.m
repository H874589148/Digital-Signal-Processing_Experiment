%------------------------------------------------------------------------
% exa100800_xcov.m,  to test xcov.m  ;
%------------------------------------------------------------------------
clear;

 N=256;
 f=.1;a1=5;a2=3;
 Mlag=N/4;

 % 产生两个正弦加白噪声的数据；
 x=a1*sin(2*pi*f*(0:N-1))+2*randn(1,N);
 y=a2*sin(2*pi*f*(0:N-1))+randn(1,N);
 subplot(3,1,1);
 plot(x(1:N/2));grid on;
 subplot(3,1,2);
 plot(y(1:N/2));grid on;
 
 % 求这两个数据向量的协方差函数；
 covxy=xcov(x,y,Mlag,'biased');
 subplot(3,1,3);
 plot((-Mlag:1:Mlag),covxy); 
 

