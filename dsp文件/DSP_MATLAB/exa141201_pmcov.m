%-------------------------------------------------------------------------
%exa141201_pmcov.m, for example 14.12.1 
%to test pmcov.m;
%-------------------------------------------------------------------------
clear all;

%��������
load test x;

N=4096;
fn=-0.5:1/N:0.5-1/N;

% ʹ�øĽ���Э�����㷨�õ������׹��ƣ�
xpsd=pmcov(x,10,N);
pmax=max(xpsd);
xpsd=xpsd/pmax;
xpsd=10*log10(xpsd+0.000001);
plot(fn,fftshift(xpsd));grid on;

