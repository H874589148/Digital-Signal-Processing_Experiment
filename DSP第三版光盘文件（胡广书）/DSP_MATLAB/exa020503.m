%---------------------------------------------------------------------------
% exa020503.m, for example 2.5.3 and fig 2.5.7,
%---------------------------------------------------------------------------
clear all;

% 说明极零点位置对幅频响应的影响；
p=0.8;r=0.85;alpha=pi/4;N=25;
b1=[1,1];a1=[1 -p];a=(1-p)/2;b1=b1*a;
b2=[1,-1];a2=[1 -p];b=(1+p)/2;b2=b2*b;
b3=[1 0 -1];a3=[1 -2*r*cos(alpha) r*r];
c1=exp(j*2*alpha);
c=abs(1-c1)/((1-r)*abs(1-r*c1));b3=b3/c;
h1=impz(b1,a1,N);
subplot(331);stem(h1,'.k')
subplot(332);zplane(b1,a1)
[H1,P]=freqz(b1,a1,256,'whole',1);
subplot(333);plot(P,abs(H1));grid on;

h2=impz(b2,a2,N);
subplot(334);stem(h2,'.k')
hold on;plot(zeros(size(h2)));
subplot(335);zplane(b2,a2)

[H2,P]=freqz(b2,a2,256,'whole',1);
subplot(336);plot(P,abs(H2));grid on;
h3=impz(b3,a3,N);
subplot(337);stem(h3,'.k')
hold on;plot(zeros(size(h3)));

subplot(338);zplane(b3,a3)

[H3,P]=freqz(b3,a3,256,'whole',1);
subplot(339);plot(P,abs(H3));grid on;

