close all;
clear all;
a = [0.95*exp(1i*0.3*pi) -1];
b = [0.95*exp(-1i*0.3*pi) -1];
c = [1 -1.4*exp(1i*0.4*pi)];
d = [1 -1.4*exp(-1i*0.4*pi)];
p = conv(conv(a,b),conv(c,d));
p = abs(p);
for m=1:5
    q(m)=0;
end
for m=1:5
    for n=1:m
        q(m)=q(m)+p(n)^2;
    end
end