%--------------------------------------------------------------------------
% exa050401_2 for example 5.4.1 and fig5.4.2
% to explain the  three -order all-pass system;
%--------------------------------------------------------------------------
clear all;

% 三阶全通系统；
N=30;
b=[0.512 -0.265 -0.3314 1];
a=[1 -0.3314 -0.265 0.512];
subplot(221)
zplane(b,a);
%
[H w]=freqz(b,a,16,1);
subplot(222)
a1=abs(H);
Ha=a1.*a1;
plot(w,Ha);grid on;
%
subplot(223)
plot(w,unwrap(angle(H)));grid on;
%
h=impz(b,a,N);
t=0:N-1;
subplot(224)
stem(t,h,'.')
hold on;
plot(t,zeros(size(h)))
