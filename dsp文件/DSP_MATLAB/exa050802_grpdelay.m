% ------------------------------------------------------------------------------
% exa050802_grpdelay.m, for example 5.8.2;
% to test grpdelay.m and to compute the Group-Delay;
% ------------------------------------------------------------------------------
clear all;

N=20;

% 给定两个系统；
a1=[1 0 -0.81];
b1=[1 -1 0.75 -0.25 0.0625];
b2=[1.0000 4.0500 8.1000 14.9956 27.7248 43.2996 51.1831 43.2996...
      27.7248 14.9956 8.1000 4.0500 1.00];
a2=1;

% 分别求这两个系统的群延迟；
[gd1 w]=grpdelay(b1,a1,256,1);
[gd2 w]=grpdelay(b2,a2,256,1);
subplot(311);plot(w,gd1);grid on;
xlabel('f/Hz');
ylabel('GD for H1')
subplot(312);plot(w,gd2);grid on;
xlabel('f/Hz');
ylabel('GD for H2')



