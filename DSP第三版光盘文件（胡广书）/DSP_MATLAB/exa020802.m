%-----------------------------------------------------------------
% exa020802, for example2.8.1 ~ 2.8.3  
% to test impz.m,filter and freqz
%-----------------------------------------------------------------
clear;
% �����˲����ĳ����Ӧ
b=[.001836,.007344,.011016,.007374,.001836];
a=[1,-3.0544,3.8291,-2.2925,.55075];
[h,t]=impz(b,a,40);
subplot(221)
stem(t,h,'.');grid on;
ylabel('h(n)')
xlabel('n')

% �����˲����Ľ�Ծ��Ӧ
x=ones(100);t=1:100;
y=filter(b,a,x);
subplot(222)
plot(t,x,'g.',t,y,'k-');grid on;
ylabel('x(n)  and  y(n)')
xlabel('n')

% �����˲����ķ�Ƶ��Ӧ����Ƶ��Ӧ(����Ʊ�ʾ)
[H,w]=freqz(b,a,256,'whole',1);      %��Ƶ����Ӧ��
Hr=abs(H);                           %���Ƶ��
Hphase=angle(H);                     %����Ƶ��
Hphase=unwrap(Hphase);               %����ƣ�
subplot(223)
plot(w,Hr);grid on;
ylabel('��Ƶ��Ӧ')
xlabel('��һ��Ƶ��')
subplot(224)
plot(w,Hphase);grid on;
ylabel('��Ƶ��Ӧ')
xlabel('��һ��Ƶ��')

