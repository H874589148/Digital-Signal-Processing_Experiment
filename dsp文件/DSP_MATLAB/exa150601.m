% exa150601; 求解维纳滤波器
clear all;
n = (1:1000)';
N=1000;
s = sin(0.1*pi*n);
d=s;
% d is the desired signal in this setup.
v = 0.8*randn(1000,1);
ma = [1, -0.8, 0.4 , -0.3];
x = filter(ma,1,v)+s;
%x will be the input to the Wiener filters,
M = 13;


b = firwiener(M-1,x,d); % Optimal FIR Wiener filter
%[W,R,P,V,Lam,dLam,kurt]=firwiener(M-1,x,d);

y = filter(b,1,x);   % Estimate of x using Wiener filter
e = d - y;            % Estimate of actual sinusoid

figure(1);
subplot(221),plot(n(900:end),x(900:end))
subplot(222),plot(n(900:end),e(900:end))
subplot(223),plot(n(900:end),[y(900:end),d(900:end)])
subplot(224),stem(b)

% 下面的程序直接求解（13.3.3）式和（13.3.4）式
rd=xcorr(d,'biased');
rx=xcorr(x,'biased');
rxd=xcorr(d,x,'biased');
Rx=toeplitz(rx(N:(N+(M-1))));
INVRx=inv(Rx);
h=INVRx*rxd(N:(N+(M-1)))
e_min=rd(N)-rxd(N:(N+(M-1)))'*h;
e_min

