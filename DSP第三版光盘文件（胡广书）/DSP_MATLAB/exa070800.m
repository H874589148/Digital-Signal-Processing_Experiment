%----------------------------------------------------------------------------
%  exa070800.m,   for fig. 7.8.1,
%  to test chebwin.m and kaiser.m,
%----------------------------------------------------------------------------
clear all;

% ÇóÇÐ±ÈÑ©·ò´°º¯ÊýºÍÆµÆ×£»
N=31;
A=40;
w=chebwin(N,A);
[W,f]=freqz(w,1,256,'whole',1);
subplot(321)
t=0:N-1;
stem(t,w,'.k')
ylabel(' chebyshev')
W=20*log10(abs(W)/abs(W(1)));
subplot(322)
f=f-0.5;
plot(f,fftshift(W));grid on;

% Çó¿­Èû´°º¯ÊýºÍÆµÆ×£»
beta=5;
w=kaiser(N,beta);
[W,f]=freqz(w,1,256,'whole',1);
subplot(323)
stem(t,w,'.k')
ylabel( 'kaiser')
W=20*log10(abs(W)/abs(W(1)));
subplot(324)
f=f-0.5;
plot(f,fftshift(W));grid on;

% Çó¿­Èû´°º¯ÊýºÍÆµÆ×£»
beta=10;
w=kaiser(N,beta);
[W,f]=freqz(w,1,256,'whole',1);
subplot(325)
stem(t,w,'.k')
ylabel( 'kaiser')
W=20*log10(abs(W)/abs(W(1)));
subplot(326)
f=f-0.5;
plot(f,fftshift(W));grid on;
