%-----------------------------------------------------------------
% exa011006_conv.m: for example 1.10.6
% to test conv.m 
% 计算两个序列的线性卷积；
%-----------------------------------------------------------------
clear;

N=5;
M=6;
L=N+M-1;
x=[1,2,3,4,5];
h=[6,2,3,6,4,2];
y=conv(x,h);
nx=0:N-1;
nh=0:M-1;
ny=0:L-1;

subplot(231);
stem(nx,x,'.k');xlabel('n');ylabel('x(n)');grid on;
subplot(232);
stem(nh,h,'.k');xlabel('n');ylabel('h(n)');grid on;
subplot(233);
stem(ny,y,'.k');xlabel('n');ylabel('y(n)');grid on;
y


   
   
  