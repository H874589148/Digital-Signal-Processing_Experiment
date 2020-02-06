%-------------------------------------------------------------------------
% exa090801_in_de_re.m, for example 9.8.1
% to test interp.m, decimate.m and resample.m
%-------------------------------------------------------------------------
clear all;

% 得到原始信号；
i=1:80;
x=sin(0.05*pi*i);

L=2;
M=3;
subplot(221);
stem(x,'.k');grid;
xlabel('n');ylabel('x(n)');
title('original signal');

% 作 L 倍插值；
y1=interp(x,L);
subplot(222);
stem(y1,'.k');grid;
xlabel('n');ylabel('y1(n)');
title('signal after interpolation');

% 作 M 倍抽取；
y2=decimate(x,M,'fir');
subplot(223);
stem(y2,'.k');grid;
xlabel('n');ylabel('y2(n)');
title('signal after decimation');

% 同时实现抽取和插值；
y3=resample(x,L,M);
subplot(224);
stem(y3,'.k');grid;
xlabel('n');ylabel('y3(n)');
title('signal after L/M alteration');
