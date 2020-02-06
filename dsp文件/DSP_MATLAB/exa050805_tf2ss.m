% ------------------------------------------------------------------------------
% exa050805_tf2ss.m , for example 5.8.5
% to test tf2ss.m and ss2tf.m, to realize the conversion  between H(z) and its
%                                 state variable represent.
% ------------------------------------------------------------------------------
clear;

b=[1 0.8 -1 -0.8];     
a=[1 -1.7 1.53 -0.648];
[A,B,C,D]=tf2ss(b,a)
% H(z) to state variable represent.

[b1,a1]=ss2tf(A,B,C,D)
% state variable represent to H(z)
