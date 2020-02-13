/********************************************************
*
*   Copyright (c) 2007, BeiJing EFLAG Technology Co., LTD.
*   All rights reserved.
*
*   文件名称 ： sys_init.c
*   摘 要    ： 工程的初始化代码
*
*   当前版本 ： 
*   作 者    ： 
*   完成日期 ： 
*
*   取代版本 ：
*   原作者   ： 
*   修改内容 ：
*   完成日期 ： 
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
*	函数名        : Init_PLL
*	函数功能      : 初始化BF533的PLL
*	函数输入参数  : 
*	函数输出      : 
*	说明          :
*
********************************************************/
void Init_PLL(void)
{
	int iIMASK_Value;
	sysreg_write(reg_SYSCFG, 0x32); //初始化系统配置寄存器

	
	*pPLL_DIV = 0x0004;// 设置 VCO/CCLK = 1, 和 VCO/SCLK = 4 
	
	// 准备修改PLL 
	*pPLL_LOCKCNT	= 0x0200; 
	*pPLL_CTL		= 0x2600; // 设置 VCO/CLKIN = 19

	// 执行PLL编程序列
	*pSIC_IWR = 0x00000001; // 尽在PLL唤醒中断时使能
	iIMASK_Value	= cli(); // 关闭中断
	idle(); // 等待PLL唤醒中断
	sti(iIMASK_Value);
}
/********************************************************
*
*	函数名        : Init_EBIU
*	函数功能      : 配置BF533的EBIU
*	函数输入参数  : 
*	函数输出      : 
*	说明          :
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
*	函数名        : Init_SDRAM
*	函数功能      : 配置SDRAM
*	函数输入参数  : 
*	函数输出      : 
*	说明          :
*
********************************************************/
void Init_SDRAM(void)
{
	*pEBIU_SDRRC	= 0x00000817;	
	*pEBIU_SDBCTL	= 0x00000013;	
	*pEBIU_SDGCTL	= 0x0091998d;	

	
}

