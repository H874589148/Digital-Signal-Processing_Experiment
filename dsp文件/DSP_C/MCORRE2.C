#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mcorre2(complex x[],complex y[],int m,int n,int icorre)
{
/*---------------------------------------------------------------------
  Routinue mcorre2: To Compute the Correlation  Function of x(i) and
  y(i) by DFT. x(i),y(i),i=0,...,m-1;But the dimension n of x,y must
  be >=2*m and be the power of 2 ; in chapter 11.
  If: icorre=0: For auto-correlation
      icorre=1: For cross-correlation
                                      in chapter 11
---------------------------------------------------------------------*/
        int i,s,k;
        complex z;
	s=n;
	do
	{
	  s=s/2.;
	  k=s-2;
	 }while(k>0);
	 if(k<0)exit(1);
	 for(i=m;i<n;i++)
	   {
	    x[i].real=0.;
	    x[i].imag=0.0;
            }
        msplfft(x,n,-1);
	if(icorre==1)
	  {
	      for(i=m;i<n;i++)
		{y[i].real=0.;
		 y[i].imag=0.0;
		 }
	     msplfft(y,n,-1);
	     for(k=0;k<n;k++)
		{z.real=x[k].real;z.imag=x[k].imag;
		 x[k].real=(z.real*y[k].real+z.imag*y[k].imag)/(float)(m);
		 x[k].imag=(z.real*y[k].imag-z.imag*y[k].real)/(float)(m);
		 }
	 }
	 else
        for(k=0;k<n;k++)
	   {
	    x[k].real=pow(mabs(x[k]),2)/(float)(m);
            x[k].imag=0.0;
	     }
	msplfft(x,n,1);
        return;
        }

