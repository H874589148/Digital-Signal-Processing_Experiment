clear all;
close all;
% ���� IIR�˲�����
H1=[1 -0.6 -1.44 0.864];
H2=[1 -0.98 0.9 -0.898];

k1=tf2latc(H1);      % ��H1��latticeϵ��
k2=tf2latc(H2);      % ��H2��latticeϵ��
%[k1,v1]=tf2latc(H1,1);      % ��H1��latticeϵ��
%[k2,v2]=tf2latc(H2,1);      % ��H2��latticeϵ��
[k3,c]=tf2latc(H1,H2);    % ��H3��latticeϵ��
