%----------------------------------------------------------------------------
%  exa070804_remez_2.m,  for example 7.8.4 and 7.4.2,
%  to test remezord.m,
%----------------------------------------------------------------------------
clear all;

% 先求滤波器的阶次；
f=[.14 .18 .22 .26 .34 .38 .42 .46 .54 .58 .62 .66];
A=[1 0 1 0 1 0 1];
rp=0.153;
rs=16.92;
devp=10^(rp/20)-1;
devs=10^(-rs/20);
dev=[devp devs devp devs devp devs devp];
[n,f0,A0,w]=remezord(f,A,dev)

%再用切比雪夫最佳一致逼近设计多带线性相位FIR滤波器；
b=remez(n+1,f0,A0,w);

[h,w]=freqz(b,1,256,1);
hr=abs(h);
h=abs(h);
h=20*log10(h);
figure(1)
stem(b,'.');grid;
figure(2)
plot(w,h);grid;

