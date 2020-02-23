%-----------------------------------------------------------------
% exa010101.m: for example 1.1.1 and to generate Fig1.1.8a,b,c
%-----------------------------------------------------------------
clear;

% 构造离散序列x,
x1=zeros(1,5);
n=0:5;
x2=0.6.^n;
x=[x1,x2];
n1=-5:5;
subplot(231)
stem(n1,x,'.k');
xlabel('n');
title('x(n)');
for k=1:11
   y(k)=x(12-k);
end

% 将它分解为偶对称序列xe和奇对称序列xo之和
xrev=[x2,x1];
xe=(x+y)/2;
xo=(x-y)/2;
subplot(232)
stem(n1,xe,'.k')
xlabel('n');
title('xe(n)');
subplot(233)
stem(n1,xo,'.k')
xlabel('n');
title('xo(n)');

xx=zeros(1,11);
hold
plot(n1,xx)
