% ×ÔÊÊÓ¦ÔëÉùµÖÏû£¬exa160503;
% 
clear;N=1000;M=15;
s = sin(2*pi*0.05*[0:N-1]');
noise=0.5*randn(1,N);
g=fir1(M-1,0.4); 
fnoise=filter(g,1,noise);
d=s.'+fnoise;
mu = 0.015;         
ha = adaptfilt.lms(M+1,mu);
[y,e] = filter(ha,noise,d);

subplot(221);plot(800:999,d(801:1000));
ylabel('d(n)');
subplot(223);plot(800:999,e(801:1000));
ylabel('e(n)');
subplot(222);plot(800:999,s(801:1000),800:999,e(801:1000));
ylabel('s(n) and e(n)');
subplot(224);plot(800:999,y(801:1000));
ylabel('y(n)');

