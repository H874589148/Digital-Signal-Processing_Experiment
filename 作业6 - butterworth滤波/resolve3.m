%�õ����ȵ����źţ�
%u=m.*c;
%f=-0.5:1/256:0.5-1/256;
%M=fft(m,256);
%U=fft(u,256);
%�����źź͸��������Ƶ�ף�
figure
subplot(322)
plot(f,abs(fftshift(M)));grid;
ylabel('|Xa(e\^(j\omega))|')
title("x(t)�ĸ������� xa(t)��Ƶ��")
U=abs(U);
for i=1:256/2
    U(i)=2*U(i);
    U(i+128)=0;
end
subplot(321)
plot(f,fftshift(U));grid;
ylabel("|Z(e\^(j\omega))|")
title("x(t)�Ľ����ź� z(t)��Ƶ��")