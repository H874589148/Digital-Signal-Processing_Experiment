%----------------------------------------------------------------------------
% exa031001_fftfilt.m, for example 3.11.1
% to test fftfilt.m,and to finish the convolution of a long sequence with
%                       a short sequence by DFT.
%----------------------------------------------------------------------------
clear;

% �õ�����ӷ��������˲���ϵ��h�������ź�x�ľ��
% ����hΪ10��hanning����x�Ǵ��и�˹����������ź�

h=fir1(10,0.3,hanning(11));% h: a short sequence ; h is the impulse response
N=500;p=0.05;f=1/16;       %                          of a low-pass filter.
u=randn(1,N)*sqrt(p);      % u:white noise
s=sin(2*pi*f*[0:N-1]);     % s:sine signal
x=u(1:N)+s;                % x: a long sequence;
y=fftfilt(h,x);            % y=x*h
subplot(211)
plot(x);
subplot(212)
plot(y);