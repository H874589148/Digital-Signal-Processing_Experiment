%----------------------------------------------------------------------------
% exa030203, for example 3.2.5
% to explain how to do DTFT
%----------------------------------------------------------------------------
clear;

% 产生一指数信号；
N=128;
a=0.6;
for n=1:N
   x(n)=a^(n-1);
end

% 实际上是对该信号作DFT:
X=fft(x);

Xa=abs(X);
Xp=angle(X);
Xp=unwrap(Xp);
w=-0.5+1/N:1/N:0.5;   
subplot(221)
plot(w,fftshift(Xa));grid on;
subplot(222)
plot(w,fftshift(Xp));grid on;
