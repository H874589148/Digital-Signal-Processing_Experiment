%----------------------------------------------------------------------------
% exa090300_1.m,   for fig. 9.3.1,
%----------------------------------------------------------------------------
clear all;

t0=.1; 
ts=.001;              % ts=0.001 = 0.001x1
fc=250;               % 载波频率 250Hz，

t=[-t0/2:ts:t0/2];
m=sinc(100*t);          % 时域 sinc 函数，频域窗函数；
                                % 时域函数： sin(100*pi*t)/(100*pi*t)
                                % sinc 函数的主瓣内有 ? 点， 给出理论推导
c=cos(2*pi*fc*t);        % fs= ?

% 信号的调幅；
u=m.*c;

figure(1)
subplot(3,2,1)
plot(t,m(1:length(t)));grid;title('待调制信号a(t)');
subplot(3,2,3)
plot(t,c(1:length(t)));grid;title('载波信号');
subplot(3,2,5)
plot(t,u(1:length(t)));grid;title('调制信号x(t)');
f=-0.5:1/256:0.5-1/256;

% 求待调信号、载波信号和调制信号的频谱；
M=fft(m,256);
C=fft(c,256);
U=fft(u,256);

subplot(322)
plot(f,abs(fftshift(M)));grid;title('待调制信号a(t)的频谱');
subplot(324)
plot(f,abs(fftshift(C)));grid;title('载波信号的频谱');
subplot(326)
plot(f,abs(fftshift(U)));grid;title('调制信号x(t)的频谱');
