%-------------------------------------------------------------------------
% exa141201_pcov.m, for example 14.12.1 
% to test pcov.m;
%-------------------------------------------------------------------------
clear all;

% �������ݣ�
load test x;

N=4096;tn=-0.5:1/N:0.5-1/N;
% ʹ��Э�����㷨�õ������׹��ƣ�
xpsd=pcov(x,10,N);
pmax=max(xpsd);
xpsd=xpsd/pmax;
xpsd=10*log10(xpsd+0.000001);
plot(tn,fftshift(xpsd));grid on;

