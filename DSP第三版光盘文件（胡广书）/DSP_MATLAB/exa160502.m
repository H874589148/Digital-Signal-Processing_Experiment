% 逆向系统识别，exa160502; 利用RLS算法；
clear;
N=2000;M=17;
x = randn(1,N);
delay = zeros(1,M-1);
d = [delay x(1:N-M+1)]; 
g = fir1(M-1,0.4,'low');
xdata = filter(g,1,x);
p0 = 2*eye(M);
lambda = 0.98;
ha = adaptfilt.rls(M,lambda,p0);
[y,e] = filter(ha,xdata,d);

figure(1)
subplot(321); stem(g);
ylabel('g(n)');
subplot(323); stem(ha.Coefficients);
ylabel('ha(n)');

[HG,w]=freqz(g,1,1024,1);
HG1=abs(HG);
HG=20*log10(HG1+0.000001);
subplot(322);plot(w,HG);grid;
ylabel('abs(G(w))');

[HA,w]=freqz(ha.Coefficients,1,1024,1);
HA1=abs(HA);
HA=20*log10(HA1+0.000001);
subplot(324);plot(w,HA);grid;
ylabel('abs(H(w))');

for k=1:1024;
    HGA(k)=HA1(k)*HG1(k);
end
HGA=20*log10(HGA+0.000001);
subplot(326);plot(w,HGA)
ylabel('abs(H)*abs(G)');

subplot(325);plot(e(M:end));
ylabel(' error e(n)');


