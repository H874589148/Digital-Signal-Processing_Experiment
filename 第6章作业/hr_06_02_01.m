clear all;
close all;
% �����˲���ָ��:
wp = 0.2*pi; % ����ͨ��Ƶ��(Hz)
ws = 0.5*pi; % �������Ƶ��(Hz)
Rp = 3; % ͨ������(dB)
Rs = 30; % �������(dB)
% ģ��ԭ��ָ���Ƶ�ʵ���ӳ��
T = 0.00001; Fs=1/T; % �� Fs=100000
OmegaP = wp*Fs; % ԭ��ͨ��Ƶ��
OmegaS = ws*Fs; % ԭ�����Ƶ��
% ģ�������˼ԭ���˲�������:
[N,OmegaC] =buttord(OmegaP,OmegaS,Rp,Rs,'s') % ԭ�͵Ľ����ͽ�ֹƵ�ʼ���
%%***������˼�˲����״� = 4
[z0,p0,k0] = buttap(N); % ��һ��������˼ԭ����ƺ���
p = p0*OmegaC; z = z0*OmegaC; % ���㼫����� Omegac���õ��ǹ�һ���㼫��
k = k0*OmegaC^N; % �� k0 ���� Omegac^N,�õ��ǹ�һ�� k
num = k*real(poly(z)); % �����������ϵ������
den = real(poly(p)) % �ɼ�������ĸϵ������
% ������Ӧ���䷨�任:
[bd,ad] = impinvar(num,den,1/T) % ����������Ӧ���䷨����
freqz(bd,ad);
