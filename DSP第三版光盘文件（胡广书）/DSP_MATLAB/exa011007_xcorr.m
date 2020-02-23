%-----------------------------------------------------------------
% exa011007_xcorr.m: for example 1.10.7  and example 1.8.3
% to test xcorr.m
% ���������еĻ���غ�������һ�����е�����غ�����
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

% ���и�˹����������źŵ������
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

% ��˹���빦����ԭ����p1����Ϊp2���ٹ۲����źŵ������
u2=u*sqrt(p2);
x2=u2(1:N)+s;
rx2=xcorr(x2,Mlag,'biased');
subplot(222);
plot(x2(1:Mlag));
xlabel('n');ylabel('x2(n)');grid on;
subplot(224);
plot((-Mlag:Mlag),rx2);
grid on;xlabel('m');ylabel('rx2(m)');



   