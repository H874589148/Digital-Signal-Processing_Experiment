clear all;
close all;
G = tf([1],conv([1 1],[1 -2]));
K = 100;
C = tf([K K/2],[1 2]);
%整个系统的传递函数及零极点
sys = feedback(G*C,1,-1)
sys = feedback(G*C,1)
[z,p,k] = zpkdata(sys)
Z = z{:}
P = p{:}
pzmap(sys)