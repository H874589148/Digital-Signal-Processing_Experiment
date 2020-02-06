%-----------------------------------------------------------------
% exa011005_chirp.m: for example 1.10.5
% to test chirp.m and to generate the chirp signal x(t) 
% 产生一 chirp 信号；
% chirp(T0,F0,T1,F1):
% T0: 信号的开始时间；    F0:信号在T0时的瞬时频率，单位为Hz；
% T1: 信号的结束时间；    F1:信号在T1时的瞬时频率，单位为Hz；
%-----------------------------------------------------------------
  clear;
  
  t=0:0.001:1;   
  x=chirp(t,0,1,125);
  plot(t,x);
  ylabel('x(t)')     
  xlabel('t')     

   
   
  