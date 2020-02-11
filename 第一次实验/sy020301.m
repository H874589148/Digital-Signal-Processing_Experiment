n=0:50; A=1; T=1;
a=0.4; w0=2.0734;
x=A*exp(-a*n*T).*sin(w0*n*T);
subplot(3,1,1);stem(n,x);title('xa时域特性');
k=-25:25;
X=x*(exp(-j*pi/12.5)).^(n'*k);
magX=abs(X);
subplot(3,1,2);stem(k,magX);title('xa的幅度特性');
angX=angle(X);
subplot(3,1,3);stem(k,angX);title('xa的相位特性')