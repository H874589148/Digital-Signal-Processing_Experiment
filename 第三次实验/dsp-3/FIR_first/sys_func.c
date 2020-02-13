/********************************************************
*
*   Copyright (c) 2007, BeiJing EFLAG Technology Co., LTD.
*   All rights reserved.
*
*   文件名称 ： sys_func.c
*   摘 要    ： 数据处理代码等
*
*   当前版本 ： 0.1
*   作 者    ： ellie
*   完成日期 ： 2008年
*
*   取代版本 ：
*   原作者   ： 
*   修改内容 ：
*   完成日期 ： 
*
********************************************************/
#include <ccblkfn.h>
#include <cdefBF533.h>

#include "sys_func.h"
#include "sys_res.h"

/********************************************************
*
*	函数名        : Delay
*	函数功能      : 延时
*	函数输入参数  : 
*	函数输出      : 
*	说明          :  
*
********************************************************/

void Delay(unsigned int Value)
{
	unsigned int i=0;
	for(i=0;i<Value;i++)
		{;		
		}
}
/********************************************************
*
*	函数名        : GetSCLK
*	函数功能      : 获得当前系统时钟频率
*	函数输入参数  : 
*	函数输出      : 系统时钟频率
*	说明          :  
*
********************************************************/
unsigned int GetSCLK(void)
{
    unsigned short stmp;
	unsigned int sclk;
	stmp=*pPLL_CTL;
	ssync();
	stmp&=0xff00;
	stmp>>=9;
	sclk=CLK_IN*(stmp);
	stmp=*pPLL_DIV;
	stmp&=0xf;
	sclk/=stmp;
	return sclk;
}
/********************************************************
*
*	函数名        : SetLED
*	函数功能      : 设置LED状态
*	函数输入参数  : LED状态，按位表示LED状态，每位表示1个LED，0为灭，1为亮
*	函数输出      : 
*	说明          :  
*
********************************************************/
void SetLED(unsigned int nLed)
{
    *pLED = ~nLed;
}
