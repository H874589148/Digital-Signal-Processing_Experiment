clear all;
close all;
% �����˲���ָ��:
wp = 0.2*pi; % ����ͨ��Ƶ��(Hz)
ws = 0.5*pi; % �������Ƶ��(Hz)
Rp = 3; % ͨ������(dB)
Rs = 30; % �������(dB)
OmegaP=tan(wp/2); % ����ԭʼҪ��
OmegaS=tan(ws/2); % ����ԭʼҪ��
N0 = log10((10.^(0.1*abs(Rp))-1)./(10.^(0.1*abs(Rs))-1))/(2*log10(OmegaP/OmegaS));
N = ceil( N0 ) % ���� N ����ƹ�ʽ
OmegaC = OmegaP / ( (10^(.1*abs(Rp)) - 1)^(1/(2*N)) ) % ���� OmegaC ����ƹ�ʽ
OmegaC = OmegaS / ( (10^(.1*abs(Rs)) - 1)^(1/(2*N)) ) % ���� OmegaC ����ƹ�ʽ
[N, OmegaC] =buttord(OmegaP, OmegaS, Rp, Rs, 's') % �����źŴ��������й��� N �� OmegaC �Ĺ�ʽ
[z0,p0,k0] = buttap(N) % ���� buttap ����,�õ�ϵͳ�����ƽ���㼫��
b0=k0*real(poly(z0)), a0=real(poly(p0)) % ���һ���˲���ϵ�� b0,a0
Nm=length(a0)-length(b0); % �󼫵������������֮�� Nm
k = k0*OmegaC^Nm; % �� k0 ���� Omegac^Nm,�õ��ǹ�һ�� k
p = p0*OmegaC; z = z0*OmegaC; % ���㼫����� Omegac���õ��ǹ�һ���㼫��
b=k*real(poly(z)); a=real(poly(p)) % ��ǹ�һ���˲���ϵ�� b,a
%pause
wx=[OmegaP,OmegaS]/OmegaC; % ����Ƶ������[OmegaP,OmegaS]
Hx=freqs(b0,a0,wx) % ����������ϵķ�����
dbHx=20*log10(abs(Hx)) % ��Ϊ�ֱ�ֵ�������Ƿ�ﵽҪ��
freqs(b,a) % ��������ͼ
[G,sos]=tf2sos(b0,a0) % ��Ϊ���׼�����ʽ
set(gcf,'color','w') % ��ͼ�α���ɫΪ��