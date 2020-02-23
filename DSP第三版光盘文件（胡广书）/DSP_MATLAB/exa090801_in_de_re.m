%-------------------------------------------------------------------------
% exa090801_in_de_re.m, for example 9.8.1
% to test interp.m, decimate.m and resample.m
%-------------------------------------------------------------------------
clear all;

% �õ�ԭʼ�źţ�
i=1:80;
x=sin(0.05*pi*i);

L=2;
M=3;
subplot(221);
stem(x,'.k');grid;
xlabel('n');ylabel('x(n)');
title('original signal');

% �� L ����ֵ��
y1=interp(x,L);
subplot(222);
stem(y1,'.k');grid;
xlabel('n');ylabel('y1(n)');
title('signal after interpolation');

% �� M ����ȡ��
y2=decimate(x,M,'fir');
subplot(223);
stem(y2,'.k');grid;
xlabel('n');ylabel('y2(n)');
title('signal after decimation');

% ͬʱʵ�ֳ�ȡ�Ͳ�ֵ��
y3=resample(x,L,M);
subplot(224);
stem(y3,'.k');grid;
xlabel('n');ylabel('y3(n)');
title('signal after L/M alteration');
