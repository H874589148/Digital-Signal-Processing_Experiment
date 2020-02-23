%-------------------------------------------------------------------------
% exa141202.m, for example 14.12.2;
% to test aryule,arburg,arcov,armcov;
%-------------------------------------------------------------------------
clear all;
load test x;

% ������ط���ARģ�͵�ϵ������СԤ�����������
[a,E1]=aryule(x,10);
figure(1)
subplot(411)
stem(abs(a),'.')
ylabel(' for aryule');

% ��Burg����ARģ�͵�ϵ��������ϵ������СԤ�����������
[a,E2,k]=arburg(x,10);
subplot(412)
stem(abs(a),'.')
ylabel(' for arburg');

% ��Э�����ARģ�͵�ϵ������СԤ�����������
[a,E3]=arcov(x,10);
subplot(413)
stem(abs(a),'.')
ylabel(' for cov');

% �øĽ���Э�����ARģ�͵�ϵ������СԤ�����������
[a,E4]=armcov(x,10);
subplot(414)
stem(abs(a),'.')
ylabel(' for armcov');

figure(2)
stem(abs(k),'.');
ylabel(' for arburg');

E1
E2
E3
E4

