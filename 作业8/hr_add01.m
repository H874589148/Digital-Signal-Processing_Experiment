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
subplot(311);pzmap(sys);

subplot(312);step(sys);title('��Ծ��Ӧ');grid;
subplot(313);impulse(sys);title('�弤��Ӧ');grid;
%syms s;
%num3=sym2poly(k*(s+1/2));
%den3=sym2poly((s+1)*(s+2)*(s-2)+k*(s+1/2));
%h=impz(num3,den3);
%subplot(313);plot(h);title('�弤��Ӧ');grid;
