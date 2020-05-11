clear all;
close all;
% 数字滤波器指标:
wp = 0.2*pi; % 数字通带频率(Hz)
ws = 0.5*pi; % 数字阻带频率(Hz)
Rp = 3; % 通带波动(dB)
Rs = 30; % 阻带波动(dB)
% 模拟原型指标对频率的逆映射
T = 0.00001; Fs=1/T; % 置 Fs=100000
OmegaP = wp*Fs; % 原型通带频率
OmegaS = ws*Fs; % 原型阻带频率
% 模拟巴特沃思原型滤波器计算:
[N,OmegaC] =buttord(OmegaP,OmegaS,Rp,Rs,'s') % 原型的阶数和截止频率计算
%%***巴特沃思滤波器阶次 = 4
[z0,p0,k0] = buttap(N); % 归一化巴特沃思原型设计函数
p = p0*OmegaC; z = z0*OmegaC; % 将零极点乘以 Omegac，得到非归一化零极点
k = k0*OmegaC^N; % 将 k0 乘以 Omegac^N,得到非归一化 k
num = k*real(poly(z)); % 由零点计算分子系数向量
den = real(poly(p)) % 由极点计算分母系数向量
% 脉冲响应不变法变换:
[bd,ad] = impinvar(num,den,1/T) % 调用脉冲响应不变法函数
freqz(bd,ad);
