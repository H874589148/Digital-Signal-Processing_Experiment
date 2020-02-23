%----------------------------------------------------------------------------
% exa050402 for example 5.4.2 and fig5.4.3
% to explain the minimum,maxmum-phase system;
%--------------------------------------------------------------------------
clear

% 构造了关于单位圆对称的零点
N=20;
a=0.8;
b=0.6;
b1=[1 -b];
a1=[1 -a];
b2=[b -1];

% 比较二者幅频响应和相频响应
[H1 w]=freqz(b1,a1,256,1);      % 最小相位系统
[H2 w]=freqz(b2,a1,256,1);      % 最大相位系统
fupin1=abs(H1);
fupin2=abs(H2);
subplot(221)
plot(w,fupin1.*fupin1,'b.',w,fupin2.*fupin2,'b.');grid on;
subplot(222)
plot(w,unwrap(angle(H1)),w,unwrap(angle(H2)));grid on;

% 计算两个系统的冲激响应
h1=impz(b1,a1,N);
h2=impz(b2,a1,N);
t=0:N-1;
subplot(223)
stem(t,h1,'.')
hold on;
plot(t,zeros(size(h1)))
subplot(224)
stem(t,h2,'.')
hold on;
plot(t,zeros(size(h2)))