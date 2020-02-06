%-----------------------------------------------------------------
% exa011007_xcorr.m: for example 1.10.7  and example 1.8.3
% to test xcorr.m
% 求两个序列的互相关函数，或一个序列的自相关函数；
%-----------------------------------------------------------------
clear;

N=500;
p1=1;
p2=0.1;
f=1/8;
Mlag=50;
u=randn(1,N);
n=[0:N-1];
s=sin(2*pi*f*n);

% 混有高斯白噪的正弦信号的自相关
u1=u*sqrt(p1);
x1=u1(1:N)+s;
rx1=xcorr(x1,Mlag,'biased');
subplot(221);
plot(x1(1:Mlag));
xlabel('n');
ylabel('x1(n)');grid on;
subplot(223);
plot((-Mlag:Mlag),rx1);grid on;
xlabel('m');ylabel('rx1(m)');

% 高斯白噪功率由原来的p1减少为p2，再观察混合信号的自相关
u2=u*sqrt(p2);
x2=u2(1:N)+s;
rx2=xcorr(x2,Mlag,'biased');
subplot(222);
plot(x2(1:Mlag));
xlabel('n');ylabel('x2(n)');grid on;
subplot(224);
plot((-Mlag:Mlag),rx2);
grid on;xlabel('m');ylabel('rx2(m)');



   