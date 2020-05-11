clear all;
close all;
% 给定 IIR滤波器；
H1=[1 -0.6 -1.44 0.864];
H2=[1 -0.98 0.9 -0.898];

k1=tf2latc(H1);      % 求H1的lattice系数
k2=tf2latc(H2);      % 求H2的lattice系数
%[k1,v1]=tf2latc(H1,1);      % 求H1的lattice系数
%[k2,v2]=tf2latc(H2,1);      % 求H2的lattice系数
[k3,c]=tf2latc(H1,H2);    % 求H3的lattice系数
