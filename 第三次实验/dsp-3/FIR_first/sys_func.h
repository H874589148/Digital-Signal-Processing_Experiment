/********************************************************
*
*   Copyright (c) 2007, BeiJing EFLAG Technology Co., LTD.
*   All rights reserved.
*
*   文件名称 ： sys_func.h
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
#ifndef _SYS_FUNC_H_
#define _SYS_FUNC_H_

#define RET_OK		(0)
#define RET_FAILED	(-1)

void Delay(unsigned int);
unsigned int GetSCLK(void);
void SetLED(unsigned int nLed);


#endif	/* _SYS_FUNC_H_ */
