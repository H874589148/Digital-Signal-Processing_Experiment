clear all;
close all;
G = tf([1],conv([1 1],[1 -2]));
K = 100;
C = tf([K K/2],[1 2]);
%����ϵͳ�Ĵ��ݺ������㼫��
sys = feedback(G*C,1,-1)
sys = feedback(G*C,1)
[z,p,k] = zpkdata(sys)
Z = z{:}
P = p{:}
pzmap(sys)