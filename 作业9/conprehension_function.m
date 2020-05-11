clear all;
close all;
% ���� IIR�˲�����
B=[0.0201 0 -0.0402 0 0.0201];
A=[1 -1.637 2.237 -1.307 0.641];

w1=0.1*pi;w2=0.35*pi;   % �����ź� x��
N=100;n=0:N-1;
x=cos(w1*n)+cos(w2*n);

y1=filter(B,A,x);       % ֱ���˲�
[k,c]=tf2latc(B,A);      % ��latticeϵ��

[y2,g]=latcfilt(k,c,x); % ��lattice�˲���
subplot(411);plot(x(10:N-1));grid on;
subplot(412);plot(y1(10:N-1));grid on;
subplot(413);plot(y2(10:N-1));grid on;
subplot(414);plot(g(10:N-1));grid on;

sys = tf(B,1);       % Ϊ�򵥻������÷�ĸΪ1
sys = tf(B,1,-1);    % ʹ��"-1"�������ɢʱ�䴫�ݺ���ģ�ͣ���ָ����������
[k2,c2] = tf2latc(B,1);
[y3,g3] = latcfilt(k2,c2,[1, zeros(1,99)]);
[y4,g4] = latcfilt(k2,c2,[1, zeros(1,9), 1, zeros(1,89)]);
[y5,g5] = latcfilt(k2,c2,[1, zeros(1,2), 1, zeros(1,96)]);
