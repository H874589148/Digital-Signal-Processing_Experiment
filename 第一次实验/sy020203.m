n=0:50;
x=[ones(1,5) zeros(1,46)];
subplot(3,1,1);stem(n,x);title('xc时域特性');
k=-25:25;
X=x*(exp(-j*pi/12.5)).^(n'*k);
magX=abs(X);
subplot(3,1,2);stem(k,magX);title('xc的幅度特性');
angX=angle(X);
subplot(3,1,3);stem(k,angX);title('xc的相位特性')