%------------------------------------------------------------------------
% exa050501.m, for example 5.5.1  and fig5.5.1
% to explain the spectra factorization
%------------------------------------------------------------------------
clear all;

% 设定10个零点，计算出多项式系数，作为滤波器系数
a=1;N0=128;d=j*2*pi/3;
z1=exp(j*2*pi/3);
z2=exp(-j*2*pi/3);
z3=0.6*exp(j*pi/3);
z4=0.6*exp(-j*pi/3);
z5=exp(j*pi/3)/0.6;
z6=exp(-j*pi/3)/0.6;
Z=[-0.8 -1/0.8 -0.6 -1/0.6 z1 z2 z1 z2 z3 z4 z5 z6];
B=poly(Z);
B=B/B(1)
t=0:length(B)-1;

subplot(331)
stem(t,B,'.');
subplot(332)
[H,W]=freqz(B,a,N0,1);
Hm=max(abs(H));
plot(W,abs(H)/Hm);grid on;
subplot(333)
zplane(B,a);

% 取出绝对值较大的一半零点，重新设计滤波器
Z=roots(B);
Z1=sort(Z)
ll=length(Z1)/2;
ZZ1=Z1(1:ll)
ZZ2=Z1(ll+1:2*ll)
%
B1=real(poly(ZZ1));
B1=B1/B1(1)
t=0:length(B1)-1;
[H,W]=freqz(B1,a,N0,1);
subplot(335)
Hm=max(abs(H));
plot(W,abs(H)/Hm);grid on;
subplot(334)
stem(t,B1,'.');
subplot(336)
zplane(B1,a);

% 用剩下的绝对值较小的一半零点，重新设计滤波器 
B2=real(poly(ZZ2));
B2=B2/B2(1)
[H,W]=freqz(B2,a,N0,1);
Hm=max(abs(H));
subplot(338)
plot(W,abs(H)/Hm);grid on;
subplot(337)
t=0:length(B2)-1;
stem(t,B2,'.')
subplot(339)
zplane(B2,a)