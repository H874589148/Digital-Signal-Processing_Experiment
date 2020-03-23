N1 = 12; N2 = 24;
n = 0 : 1 : N1 - 1;
n1 = 0 : 1 : N1 - 1;
n2 = 0 : 1 : N2 - 1;
xn = cos(pi*n/6);
X1 = fft(xn,N1);
X2 = fft(xn,N2);
X1 = abs(X1);
X2 = abs(X2);
xn1 = cos(pi*n1/6);
[h1 w1]=freqz(xn1,1,'whole');

subplot(3,1,1);plot(w1,abs(h1));title('序列的DTFT');
subplot(3,1,2);stem(n1,X1,'.');ylabel('|X1|');title('12点的DFT');
subplot(3,1,3);stem(n2,X2,'.');ylabel('|X2|');title('24点的DFT');
