% ------------------------------------------------------------------------------
% exa050804_latcfilt.m , for example 5.8.4
%to test latcfilt.m and to realize filtering with LATTICE coefficient.
% ------------------------------------------------------------------------------
clear;

% ���� IIR�˲�����
B=[0.0201 0 -0.0402 0 0.0201];
A=[1 -1.637 2.237 -1.307 0.641];

% �����ź� x��
w1=0.1*pi;w2=0.35*pi;
N=100;n=0:N-1;
x=cos(w1*n)+cos(w2*n);

%ֱ���˲���
y1=filter(B,A,x);

% ���lattice ϵ����
[k,c]=tf2latc(B,A);

% ��lattice ϵ���˲���
[y2,g]=latcfilt(k,c,x);
subplot(411);plot(x(10:N-1));grid on;
subplot(412);plot(y1(10:N-1));grid on;
subplot(413);plot(y2(10:N-1));grid on;
subplot(414);plot(g(10:N-1));grid on;
