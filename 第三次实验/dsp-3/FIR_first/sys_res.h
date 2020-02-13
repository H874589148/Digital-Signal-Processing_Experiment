/********************************************************
*
*   Copyright (c) 2007, BeiJing EFLAG Technology Co., LTD.
*   All rights reserved.
*
*   文件名称 ： sys_res.h
*   摘 要    ： 
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
#ifndef _SYS_RES_H_
#define _SYS_RES_H_

#include <cdefBF533.h>
#include <ccblkfn.h>
#include <sys\exception.h>

/*
 * CLK
 */
#define CLK_IN	(27000000) // 27M
#define CCLK	(513000000) //513M
#define SCLK	(128000000) //128M

/*
 * CPLD Registers
 */

#define pLED  				(volatile unsigned char *)0x203C0000
#define p7Section 			(volatile unsigned char *)0x203C4000
#define pCtrlSetReg1			(volatile unsigned char *)0x203C8000
#define pCtrlSetReg2			(volatile unsigned char *)0x203CC000
#define pISP1161BaseAddr	(volatile unsigned char *)0x203D8000
#define pLcdBaseAddr		(volatile unsigned char *)0x203DC000
#define pCtrlClrReg1			(volatile unsigned char *)0x203F8000
#define pCtrlClrReg2			(volatile unsigned char *)0x203FC000


#define pIDECS0BaseAddr		(volatile unsigned short *)0x203E0000
#define pIDECS1BaseAddr		(volatile unsigned short *)0x203E4000
#define pNAND_CtrlBaseaAddr	(volatile unsigned char *)0x203E8000
#define pNAND_BaseaAddr	(volatile unsigned char *)0x203EC000
#define pSPI_CtrlBaseaAddr	(volatile unsigned char *)0x203F0000

/* 
 * addresses for BW LCD
 */
#define pLcdCtrlL				(volatile unsigned char *)0x203DC800
#define pLcdStatusL			(volatile unsigned char *)0x203DCc00
#define pLcdWriteL			(volatile unsigned char *)0x203DCa00
#define pLcdReadL			(volatile unsigned char *)0x203DCe00

#define pLcdCtrlR				(volatile unsigned char *)0x203DD000
#define pLcdStatusR			(volatile unsigned char *)0x203DD400
#define pLcdWriteR			(volatile unsigned char *)0x203DD200
#define pLcdReadR			(volatile unsigned char *)0x203DD300

/*
 * Bits definition Control register in CPLD
 */
#define CTRL_ADV7181_RESET		0x01 // Active Low
#define CTRL_PPI_PF_ACTIVE		0x02 // Active High
#define CTRL_ADV7171_RESET		0x04 // Active Low
#define CTRL_ISP1582_RESET		0x08 // Active Low
#define CTRL_OV7648_OUTPUT		0x10 // Active High
#define CTRL_OV7648_RESET		0x20 // Active Low
#define CTRL_CS8900_RESET		0x40 // Active Low
#define CTRL_ISP1161_RESET		0x80 // Active Low

/*
 * Bits definition SPI control register in CPLD
 */
#define  SPI_CTRL_NONE		0x07
#define  SPI_CTRL_MCP2515	0x00
#define  SPI_CTRL_MMC		0x01
#define  SPI_CTRL_AIC23B	0x02
#define  SPI_CTRL_TSC2200	0x03

//PF
//按键KEY2-KEY4对应的PF口
#define PF_PATTERN(x)	(1<<((x)%16))
#define KEY1 	PF_PATTERN(8)	//PF8
#define KEY2 	PF_PATTERN(9)	//PF9
#define KEY3 	PF_PATTERN(10)		//PF10
#define KEY4 	PF_PATTERN(11)		//PF11

#endif	/* _SYS_RES_H_ */


