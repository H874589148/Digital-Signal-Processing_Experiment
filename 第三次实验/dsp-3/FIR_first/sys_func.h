/********************************************************
*
*   Copyright (c) 2007, BeiJing EFLAG Technology Co., LTD.
*   All rights reserved.
*
*   �ļ����� �� sys_func.h
*   ժ Ҫ    �� ���ݴ�������
*
*   ��ǰ�汾 �� 0.1
*   �� ��    �� ellie
*   ������� �� 2008��
*
*   ȡ���汾 ��
*   ԭ����   �� 
*   �޸����� ��
*   ������� �� 
*
********************************************************/
#ifndef _SYS_FUNC_H_
#define _SYS_FUNC_H_

#define RET_OK		(0)
#define RET_FAILED	(-1)

void Delay(unsigned int);
unsigned int GetSCLK(void);
void SetLED(unsigned int nLed);


#endif	/* _SYS_FUNC_H_ */
