%----------------------------------------------------------------------------
% exa090300_1.m,   for fig. 9.3.1,
%----------------------------------------------------------------------------
clear all;

t0=.1; 
ts=.001;              % ts=0.001 = 0.001x1
fc=250;               % �ز�Ƶ�� 250Hz��

t=[-t0/2:ts:t0/2];
m=sinc(100*t);          % ʱ�� sinc ������Ƶ�򴰺�����
                                % ʱ������ sin(100*pi*t)/(100*pi*t)
                                % sinc �������������� ? �㣬 ���������Ƶ�
c=cos(2*pi*fc*t);        % fs= ?

% �źŵĵ�����
u=m.*c;

figure(1)
subplot(3,2,1)
plot(t,m(1:length(t)));grid;title('�������ź�a(t)');
subplot(3,2,3)
plot(t,c(1:length(t)));grid;title('�ز��ź�');
subplot(3,2,5)
plot(t,u(1:length(t)));grid;title('�����ź�x(t)');
f=-0.5:1/256:0.5-1/256;

% ������źš��ز��źź͵����źŵ�Ƶ�ף�
M=fft(m,256);
C=fft(c,256);
U=fft(u,256);

subplot(322)
plot(f,abs(fftshift(M)));grid;title('�������ź�a(t)��Ƶ��');
subplot(324)
plot(f,abs(fftshift(C)));grid;title('�ز��źŵ�Ƶ��');
subplot(326)
plot(f,abs(fftshift(U)));grid;title('�����ź�x(t)��Ƶ��');
