%-------------------------------------------------------------------------
%exa141201_peig.m, for example 14.12.1 
%to test peig.m;
%-------------------------------------------------------------------------
clear all;

%�������ݣ�
load test x;

N=4096;fn=-0.5:1/N:0.5-1/N;
% ʹ������ؾ���ֽ�����������㷨�õ������׹��ƣ�
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


