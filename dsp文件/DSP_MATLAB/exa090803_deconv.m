%---------------------------------------------------------------------------
% exa090803_deconv.m, for example 9.8.3
% to test deconv.m;
%---------------------------------------------------------------------------
clear all;

% y = x * h;
k=0:1:7; 
x=k+1; 
h=ones(1,4);
y=conv(h,x);

% 由 y,x 作反卷积，求出 h；
[q,r]=deconv(y,x);
subplot(221);stem(h,'.k');ylabel(' h(n)');
subplot(222);stem(x,'.k');ylabel(' x(n)');
subplot(223);stem(y,'.k');ylabel(' y(n)');
subplot(224);stem(q,'.k');ylabel(' q(n)');
r
