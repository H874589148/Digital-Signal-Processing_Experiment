%-----------------------------------------------------------------
% exa020802, for example2.8.1 ~ 2.8.3  
% to test impz.m,filter and freqz
%-----------------------------------------------------------------
clear;
% 计算滤波器的冲击响应
b=[.001836,.007344,.011016,.007374,.001836];
a=[1,-3.0544,3.8291,-2.2925,.55075];
[h,t]=impz(b,a,40);
subplot(221)
stem(t,h,'.');grid on;
ylabel('h(n)')
xlabel('n')

% 计算滤波器的阶跃响应
x=ones(100);t=1:100;
y=filter(b,a,x);
subplot(222)
plot(t,x,'g.',t,y,'k-');grid on;
ylabel('x(n)  and  y(n)')
xlabel('n')

% 计算滤波器的幅频响应和相频响应(解卷绕表示)
[H,w]=freqz(b,a,256,'whole',1);      %求频率响应；
Hr=abs(H);                           %求幅频；
Hphase=angle(H);                     %求相频；
Hphase=unwrap(Hphase);               %解卷绕；
subplot(223)
plot(w,Hr);grid on;
ylabel('幅频响应')
xlabel('归一化频率')
subplot(224)
plot(w,Hphase);grid on;
ylabel('相频响应')
xlabel('归一化频率')

