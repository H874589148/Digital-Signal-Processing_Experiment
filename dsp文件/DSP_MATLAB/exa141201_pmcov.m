%-------------------------------------------------------------------------
%exa141201_pmcov.m, for example 14.12.1 
%to test pmcov.m;
%-------------------------------------------------------------------------
clear all;

%调出数据
load test x;

N=4096;
fn=-0.5:1/N:0.5-1/N;

% 使用改进的协方差算法得到功率谱估计；
xpsd=pmcov(x,10,N);
pmax=max(xpsd);
xpsd=xpsd/pmax;
xpsd=10*log10(xpsd+0.000001);
plot(fn,fftshift(xpsd));grid on;

