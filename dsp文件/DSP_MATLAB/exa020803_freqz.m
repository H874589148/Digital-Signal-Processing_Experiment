%-----------------------------------------------------------------
% exa020803_freqz.m, for example 2.8.3
% to test freqz.m and to obtain the frequency response.
%-----------------------------------------------------------------
clear all;

b=[.001836,.007344,.011016,.007374,.001836];
a=[1,-3.0544,3.8291,-2.2925,.55075];
[H,w]=freqz(b,a,256,1);
Hr=abs(H);
Hphase=angle(H);
Hphase=unwrap(Hphase);    % ½â¾íÈÆ

subplot(211)
plot(w,Hr);grid on;
ylabel(' Amplitude Freq. Res.')
subplot(212)
plot(w,Hphase);grid on;
ylabel(' Phase Freq. Res.')
