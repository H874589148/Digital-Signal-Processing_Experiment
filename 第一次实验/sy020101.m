n=0:50;
x=[1 zeros(1,50)];
subplot(3,1,1);stem(n,x);title('xbʱ������');
k=-25:25;
X=x*(exp(-j*pi/12.5)).^(n'*k);
magX=abs(X);
subplot(3,1,2);stem(k,magX);title('xb�ķ�������');
angX=angle(X);
subplot(3,1,3);stem(k,angX);title('xb����λ����')
