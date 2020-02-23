% ---------------------------------------------------------------------------
% exa070101.m,  for example 7.1.1 and fig 7.1.2,
%----------------------------------------------------------------------------
clear all;

N=128;

% 用矩形窗和文件 fir1 设计三个 FIR滤波器，长度分别为11，21，41；
b1=fir1(10,0.25,boxcar(11));
b2=fir1(20,0.25,boxcar(21));
b3=fir1(40,0.25,boxcar(41));

% 求出三个滤波器的频率响应；
h1=freqz(b1,1,N);
h2=freqz(b2,1,N);
h3=freqz(b3,1,N);

% 绘图；
Xval=0:10;
subplot(221)
stem(Xval,b1,'.k');grid;
hold on;
plot(Xval,zeros(1,11));

t=0:0.5/N:0.5-0.5/N;
N1=N/4;
for k=1:N1
   hd(k)=1;
   hd(k+N1)=0;
   hd(k+2*N1)=0;
   hd(k+3*N1)=0;
end
subplot(222)
plot(t,abs(h1),'b-',t,abs(h2),'g-',t,abs(h3),'r-',t,hd,'-');grid;
%plot(t,abs(h1),t,abs(h2),t,abs(h3),t,hd);grid;