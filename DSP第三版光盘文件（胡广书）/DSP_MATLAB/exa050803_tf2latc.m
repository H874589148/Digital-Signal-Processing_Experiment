% ------------------------------------------------------------------------------
% exa050803_tf2latc.m , for example 5.8.3
% to test tf2latc.m and latctf.m
% ------------------------------------------------------------------------------
clear;

b=[1 -1.7 1.53 -0.648];%
k=tf2latc(b)
% all-zeros system to  LATTICE;  

b1=latc2tf(k)
%  LATTICE to all-zeros system;

a=b;                   
k=tf2latc(1,a)
%  all-poles system to  LATTICE;

a1=latc2tf(k)
% LATTICE to all-poles system;

b=[1 0.8 -1 -0.8];     
[k,c]=tf2latc(b,a)
% zeros-poles system to  LATTICE;

[b2,a2]=latc2tf(k,c)
%  LATTICE to zeros-poles system;
