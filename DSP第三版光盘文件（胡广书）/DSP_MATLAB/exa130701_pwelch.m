%-------------------------------------------------------------------------
% exa130701_pwelch.m, for example 13.7.1 and fig. 13.5.1(d)
% to estimate the PSD of x(n) by Welch average;
%--------------------------------------------------------------------------
clear;

% �������ݣ�
load test x;
N=4096;
Fn=-0.5:1/N:0.5-1/N;

% �� Welch ƽ�������������ݵĹ����ף�
% xpsd=pwelch(x,N,1,hamming(33),16,'whole');     for MATLAB 5.3
xpsd=pwelch(x,hamming(33),16,N,'whole');        %for MATLAB 6.1
mmax=max(xpsd);
xpsd=xpsd/mmax;
xpsd=10*log10(xpsd+0.000001);
plot(Fn,fftshift(xpsd));grid on;

