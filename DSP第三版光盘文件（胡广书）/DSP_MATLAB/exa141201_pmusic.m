%-------------------------------------------------------------------------
%exa141201_pmusic.m, for example 14.12.1 
%to test pmusic.m;
%-------------------------------------------------------------------------
clear all;

%��������
load test x;

N=4096;
fn=-0.5:1/N:0.5-1/N;

% ʹ������ؾ���ֽ�� MUSIC �㷨�õ������׹��ƣ�
xpsd=pmusic(x',10,N);
pmax=max(xpsd);
xpsd=xpsd/pmax;
xpsd=10*log10(xpsd+0.000001);
for i=1:N
    xxpsd(i)=xpsd(N+1-i);
end
plot(fn,fftshift(xxpsd));grid on;

