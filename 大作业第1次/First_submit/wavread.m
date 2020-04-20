function [ x, fs, nbits ] = wavread( filename )
% ģ���װ�ϰ汾��wavread��������ȡ���ݡ������ʡ�����λ��
    
    % ��ȡ���ݺͲ�����
    [x, fs] = audioread(filename);
    
    % ��ȡ����λ��
    info = audioinfo(filename);
    nbits = info.BitsPerSample;
    
end