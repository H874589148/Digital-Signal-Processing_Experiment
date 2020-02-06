%----------------------------------------------------------------------
% exa050403.m, for example 5.4.3 ， fig5.4.4 and fig5.4.5
% to explain the minimum,maxmum and mixed-phase system;
%----------------------------------------------------------------------
clear all;

N=20;
b1=[1 -1 0.75 -0.25 0.0625];
b2=[0.25 -0.625 1.3125 -0.625 0.25];
b3=[0.0625 -0.25 0.75 -1 1];
a=[1 0 -0.81];
subplot(331);zplane(b1,a);      % 最小相位系统
subplot(332);zplane(b2,a);      % 混合相位系统
subplot(333);zplane(b3,a);      % 最大相位系统

% 计算三者的幅频响应
[H1 w]=freqz(b1,a,256,1);
[H2 w]=freqz(b2,a,256,1);
[H3 w]=freqz(b3,a,256,1);
fupin1=abs(H1);
fupin2=abs(H2);
fupin3=abs(H3);
subplot(337)
plot(w,abs(H1),w,abs(H2),w,abs(H3));grid on;

% 计算三者的相频响应
subplot(338)
pha1=unwrap(angle(H1));
pha2=unwrap(angle(H2));
pha3=unwrap(angle(H3));
plot(w,pha1,w,pha2,w,pha3);grid on;

% 计算三者的冲激相应
h1=impz(b1,a,N);
h2=impz(b2,a,N);
h3=impz(b3,a,N);
t=0:N-1;
subplot(334)
stem(t,h1,'.')
hold on;
plot(t,zeros(size(h1)))
subplot(335)
stem(t,h2,'.')
hold on;
plot(t,zeros(size(h2)))
subplot(336)
stem(t,h3,'.')
hold on;
plot(t,zeros(size(h3)))

% 观察三者冲激响应的能量积累情况
e1(1)=h1(1)*h1(1);
e2(1)=h2(1)*h2(1);
e3(1)=h3(1)*h3(1);
for m=2:N
    e1(m)=e1(m-1)+h1(m)*h1(m);
    e2(m)=e2(m-1)+h2(m)*h2(m);
    e3(m)=e3(m-1)+h3(m)*h3(m);
 end
subplot(339)
plot(t,e1,t,e2,t,e3);grid on;