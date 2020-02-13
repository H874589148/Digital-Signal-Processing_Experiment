/********************************************************
*
*   Copyright (c) 2007, BeiJing EFLAG Technology Co., LTD.
*   All rights reserved.
*
*   �ļ����� �� sys_init.c
*   ժ Ҫ    �� ���̵ĳ�ʼ������
*
*   ��ǰ�汾 �� 
*   �� ��    �� 
*   ������� �� 
*
*   ȡ���汾 ��
*   ԭ����   �� 
*   �޸����� ��
*   ������� �� 
*
********************************************************/
#include <ccblkfn.h>
#include <cdefBF533.h>
#include <sys\exception.h>

#include "sys_res.h"
#include "sys_init.h"
#include "sysreg.h"

/********************************************************
*
*	������        : Init_PLL
*	��������      : ��ʼ��BF533��PLL
*	�����������  : 
*	�������      : 
*	˵��          :
*
********************************************************/
void Init_PLL(void)
{
	int iIMASK_Value;
	sysreg_write(reg_SYSCFG, 0x32); //��ʼ��ϵͳ���üĴ���

	
	*pPLL_DIV = 0x0004;// ���� VCO/CCLK = 1, �� VCO/SCLK = 4 
	
	// ׼���޸�PLL 
	*pPLL_LOCKCNT	= 0x0200; 
	*pPLL_CTL		= 0x2600; // ���� VCO/CLKIN = 19

	// ִ��PLL�������
	*pSIC_IWR = 0x00000001; // ����PLL�����ж�ʱʹ��
	iIMASK_Value	= cli(); // �ر��ж�
	idle(); // �ȴ�PLL�����ж�
	sti(iIMASK_Value);
}
/********************************************************
*
*	������        : Init_EBIU
*	��������      : ����BF533��EBIU
*	�����������  : 
*	�������      : 
*	˵��          :
*
********************************************************/
void Init_EBIU(void)
{
	*pEBIU_AMBCTL0	= 0x7bb07bb0;
	*pEBIU_AMBCTL1	= 0xa4c77bb0;
	*pEBIU_AMGCTL	= 0x00ff;
    	
}


/********************************************************
*
*	������        : Init_SDRAM
*	��������      : ����SDRAM
*	�����������  : 
*	�������      : 
*	˵��          :
*
********************************************************/
void Init_SDRAM(void)
{
	*pEBIU_SDRRC	= 0x00000817;	
	*pEBIU_SDBCTL	= 0x00000013;	
	*pEBIU_SDGCTL	= 0x0091998d;	

	
}

