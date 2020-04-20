clear all;
close all;
N = 512;fs = 8000;
h = [0.01218354 -0.009012882 -0.02881839 -0.04743239 -0.04584568 -0.008692503 0.06446265 0.1544655 0.2289794 0.257883 0.2289794 0.1544655 0.06446265 -0.008692503 -0.04584568 -0.04743239 -0.02881839 -0.009012882 0.01218354];
[H,w] = freqz(h,1,N,'whole',fs);
Hr = abs(H);
Hphase = angle(H);
Hphase = unwrap(Hphase);

subplot(211);plot(w,Hr);grid on;
ylabel('Amplitude Freq. Res. ');
subplot(212);plot(w,Hphase);grid on;
ylabel('Phase Freq. Res. ');
