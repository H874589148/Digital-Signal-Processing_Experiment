%-------------------------------------------------------------------------
%exa141201_pmem.m, for example 14.12.1 
%to test pmem.m;
%-------------------------------------------------------------------------
clear all;

% �������ݣ�
load test x;

N=4096;
fn=-0.5:1/N:0.5-1/N;

% ʹ��������㷨�õ������׹��ƣ�
xpsd=pmem(x,30,N);
pmax=max(xpsd);
xpsd=xpsd/pmax;
xpsd=10*log10(xpsd+0.000001);
plot(fn,fftshift(xpsd));grid on;


