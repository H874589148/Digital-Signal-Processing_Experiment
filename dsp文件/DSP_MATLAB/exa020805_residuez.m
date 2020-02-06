%-----------------------------------------------------------------
% exa020805_residues.m, for example 2.8.5
% to test residuez.m and to obtain the residues of H(z).
%-----------------------------------------------------------------
clear;

b=[1.7,-1.69,.39];
a=[1 -1.7,0.8,-.1]; 
% 系统 H(z)=B(z)/A(z)
[r,p,k]=residuez(b,a)
% 由系数向量 b,a 求  r,p 和 k，即将H(z) 分解成如下形式：
%H(z)=1/[1-z^-1]+0.2/[1-0.5z^-1]+0.5/[1-0.2z^-1]

[b1,a1]=residuez(r,p,k)
% 由 r,p 及 k 反过来求系数向量 b 和 a;

% 令 H2(z)=A(z)/B(z),即：令 b2=a,a2=b,再一次求 r,p 和 k； 
% H2(z)称为 H(z)的逆系统
b2=a;a2=b;
[r,p,k]=residuez(b2,a2)
