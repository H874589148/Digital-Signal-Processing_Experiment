clear;
syms z
hr=(z-0.8*exp(1)^(i*pi/6))*(z-0.8*exp(1)^(-i*pi/6));
den = sym2poly(hr);   %�趨�����ķ�ĸ����
num1=[1 2 0];         %�趨�����ķ�������
subplot(221);zplane(num1,den);title('(1)�㼫��ֲ�ͼ');%����ϵͳ�������㼫��ͼ
subplot(222);impz(num1,den);title('(1)��λ������Ӧ');%����ϵͳ�����ĵ�λ������Ӧ
num2=[1 -2 0];         %�趨�����ķ�������
subplot(223);zplane(num2,den);title('(2)�㼫��ֲ�ͼ');%����ϵͳ�������㼫��ͼ
subplot(224);impz(num2,den);title('(2)��λ������Ӧ');%����ϵͳ�����ĵ�λ������Ӧ