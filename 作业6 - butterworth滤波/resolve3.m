%得到幅度调制信号；
%u=m.*c;
%f=-0.5:1/256:0.5-1/256;
%M=fft(m,256);
%U=fft(u,256);
%解析信号和复数包络的频谱；
figure
subplot(322)
plot(f,abs(fftshift(M)));grid;
ylabel('|Xa(e\^(j\omega))|')
title("x(t)的复数包络 xa(t)的频谱")
U=abs(U);
for i=1:256/2
    U(i)=2*U(i);
    U(i+128)=0;
end
subplot(321)
plot(f,fftshift(U));grid;
ylabel("|Z(e\^(j\omega))|")
title("x(t)的解析信号 z(t)的频谱")