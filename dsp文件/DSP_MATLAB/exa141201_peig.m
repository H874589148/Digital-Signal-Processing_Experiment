%-------------------------------------------------------------------------
%exa141201_peig.m, for example 14.12.1 
%to test peig.m;
%-------------------------------------------------------------------------
clear all;

%调出数据；
load test x;

N=4096;fn=-0.5:1/N:0.5-1/N;
% 使用自相关矩阵分解的特征向量算法得到功率谱估计；
[xpsd,F,V,E]=peig(x',10,N);
pmax=max(xpsd);
xpsd=xpsd/pmax;
xpsd=10*log10(xpsd+0.000001);
for i=1:N
    xxpsd(i)=xpsd(N+1-i);
end
plot(fn,fftshift(xxpsd));grid on;

size(V)
size(E)
size(V,1)
size(V,2)
abs(V)
E


