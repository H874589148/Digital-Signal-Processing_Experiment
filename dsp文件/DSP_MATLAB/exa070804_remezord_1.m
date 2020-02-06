%--------------------------------------------------------------------------
% exa070804_remezord_1.m,   for example 7.8.4 and 7.4.1,
% to test remezord.m,
%--------------------------------------------------------------------------
clear all;

% 先求滤波器的阶次；
f=[.6 .7];
A=[1 0];
rp=0.4916;
rs=44.7;
dev=[10^(rp/20)-1 10^(-rs/20)];
%
[n,f0,A0,w]=remezord(f,A,dev)
%
if rem(n,2)
   n=n+1;
end

% 再用切比雪夫最佳一致逼近设计线性相位FIR滤波器；
b=remez(n,f0,A0,w);

[h,w]=freqz(b,1,256,1);
h=abs(h);
h=20*log10(h);
figure(1)
stem(b,'.');grid;
figure(2)
plot(w,h);grid;
  