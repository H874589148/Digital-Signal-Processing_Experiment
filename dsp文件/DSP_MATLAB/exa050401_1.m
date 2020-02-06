%--------------------------------------------------------------------------
% exa050401_1 for example 5.4.1 and fig5.4.1
% to explain the one -order all-pass system;
%--------------------------------------------------------------------------
clear all;

% 一阶全通系统；
alpha=-0.8;N=20;
aa=1/alpha/alpha;
b=[1 -1/alpha];
a=[1 -alpha];
subplot(221)
zplane(b,a);
%
[H w]=freqz(b,a,256,1);
Ha=ones(1,256);
Ha1=Ha.*aa;
subplot(222);
plot(w,Ha1);grid on;
%
subplot(223)
plot(w,unwrap(angle(H)));grid on;
h=impz(b,a,N);
t=0:N-1;
subplot(224)
stem(t,h,'.')
hold on;
plot(t,zeros(size(h)))