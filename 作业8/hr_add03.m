close all;
clear all;
syms s
k=-1;
eq=(s+1)*(s+2)*(s-2)+k*(s+1/2)==0;
s=solve(eq,s);
s=double(s);
