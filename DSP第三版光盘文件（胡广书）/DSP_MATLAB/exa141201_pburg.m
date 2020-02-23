%-------------------------------------------------------------------------
%exa141201_pburg.m, for example 14.12.1 
%to test pburg.m;
%-------------------------------------------------------------------------
clear all;

% �������ݣ�
load test x;

N=4096;
fn=-0.5:1/N:0.5-1/N;
% ʹ�� Burg �㷨�õ������׹��ƣ�
xpsd=pburg(x,10,N);
pmax=max(xpsd);
xpsd=xpsd/pmax;
xpsd=10*log10(xpsd+0.000001);
plot(fn,fftshift(xpsd));grid on;

