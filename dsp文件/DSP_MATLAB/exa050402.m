%----------------------------------------------------------------------------
% exa050402 for example 5.4.2 and fig5.4.3
% to explain the minimum,maxmum-phase system;
%--------------------------------------------------------------------------
clear

% �����˹��ڵ�λԲ�ԳƵ����
N=20;
a=0.8;
b=0.6;
b1=[1 -b];
a1=[1 -a];
b2=[b -1];

% �Ƚ϶��߷�Ƶ��Ӧ����Ƶ��Ӧ
[H1 w]=freqz(b1,a1,256,1);      % ��С��λϵͳ
[H2 w]=freqz(b2,a1,256,1);      % �����λϵͳ
fupin1=abs(H1);
fupin2=abs(H2);
subplot(221)
plot(w,fupin1.*fupin1,'b.',w,fupin2.*fupin2,'b.');grid on;
subplot(222)
plot(w,unwrap(angle(H1)),w,unwrap(angle(H2)));grid on;

% ��������ϵͳ�ĳ弤��Ӧ
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