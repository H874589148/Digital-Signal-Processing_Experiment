n=-50:50; k=-25:25;                         %定义离散变量
x=[zeros(1,50) ones(1,10) zeros(1,41)];     %产生输入信号xc(n)
subplot(3,2,1);stem(n,x);title('xc时域特性');%做出时域上输入信号xc(n)的曲线
X=x*(exp(-j*pi/12.5)).^(n'*k);              %信号x(n)进行傅里叶变换得到X(k)
magX=abs(X);                                %频域信号X(k)的幅频特性
subplot(3,2,2);stem(k,magX);title('xc的幅度特性');
h=[zeros(1,41) ones(1,10) zeros(1,50)];     %产生信号xc(-n)
p=(x+h)/2;                                  %得到输入信号的偶序列p(n)
subplot(3,2,3);stem(n,p);title('xc的偶序列时域特性');
P=p*(exp(-j*pi/12.5)).^(n'*k);              %信号p(n)进行傅里叶变换得到P(k)
magP=abs(P);                                %频域信号P(k)的幅频特性
subplot(3,2,4);stem(k,magP);title('xc的偶序列的幅度特性');
q=(x-h)/2;                                  %得到输入信号的奇序列q(n)
subplot(3,2,5);stem(n,q);title('xc的奇序列的时域特性');
Q=q*(exp(-j*pi/12.5)).^(n'*k);              %信号q(n)进行傅里叶变换得到Q(k)
magQ=abs(Q);                                %频域信号Q(k)的幅频特性
subplot(3,2,6);stem(k,magQ);title('xc的奇序列的幅度特性');