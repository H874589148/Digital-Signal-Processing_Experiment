n=-50:50; k=-25:25;                         %������ɢ����
x=[zeros(1,50) ones(1,10) zeros(1,41)];     %���������ź�xc(n)
subplot(3,2,1);stem(n,x);title('xcʱ������');%����ʱ���������ź�xc(n)������
X=x*(exp(-j*pi/12.5)).^(n'*k);              %�ź�x(n)���и���Ҷ�任�õ�X(k)
magX=abs(X);                                %Ƶ���ź�X(k)�ķ�Ƶ����
subplot(3,2,2);stem(k,magX);title('xc�ķ�������');
h=[zeros(1,41) ones(1,10) zeros(1,50)];     %�����ź�xc(-n)
p=(x+h)/2;                                  %�õ������źŵ�ż����p(n)
subplot(3,2,3);stem(n,p);title('xc��ż����ʱ������');
P=p*(exp(-j*pi/12.5)).^(n'*k);              %�ź�p(n)���и���Ҷ�任�õ�P(k)
magP=abs(P);                                %Ƶ���ź�P(k)�ķ�Ƶ����
subplot(3,2,4);stem(k,magP);title('xc��ż���еķ�������');
q=(x-h)/2;                                  %�õ������źŵ�������q(n)
subplot(3,2,5);stem(n,q);title('xc�������е�ʱ������');
Q=q*(exp(-j*pi/12.5)).^(n'*k);              %�ź�q(n)���и���Ҷ�任�õ�Q(k)
magQ=abs(Q);                                %Ƶ���ź�Q(k)�ķ�Ƶ����
subplot(3,2,6);stem(k,magQ);title('xc�������еķ�������');