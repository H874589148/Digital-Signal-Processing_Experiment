#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mcmpfft(complex x[],int n,int isign)
{
/*---------------------------------------------------------------------
 Routine mcmpfft:to obtain the DFT of Complex Data x(n)
                               By Cooley-Tukey radix-2 DIT Algorithm .
 input parameters:
 x : complex array.input signal is stored in x(0) to x(n-1).
 n : the dimension of x and y.
 isign:if ISIGN=-1 For Forward Transform
       if ISIGN=+1 For Inverse Transform.
 output parameters:
 x : complex array. DFT result is stored in x(0) to x(n-1).
 Notes:
     n must be power of 2.
                                       in Chapter 5
--------------------------------------------------------------------*/
        complex t,z,ce;
        float pisign;
        int mr,m,l,j,i,nn;
        for(i=1;i<=16;i++)
	   {
		nn=pow(2,i);
	    if(n==nn) break;
	    }
	if(i>16)
	{
		printf(" N is not a power of 2 ! \n");
		return;
	}
	z.real=0.0;
        pisign=4*isign*atan(1.);
        mr=0;
        for(m=1;m<n;m++)
           {l=n;
	      while(mr+l>=n)l=l/2;
            mr=mr%l+l;
            if(mr<=m)
               continue;
            t.real=x[m].real;t.imag=x[m].imag;
            x[m].real=x[mr].real;x[m].imag=x[mr].imag;
            x[mr].real=t.real;x[mr].imag=t.imag;
            }
/*-------------------------------------------------------------------*/
	l=1;
	while(1)
	{
	  if(l>=n)
	   {
	       if(isign==-1)
		  return;
	       for(j=0;j<n;j++)
		   {
		    x[j].real=x[j].real/n;
		    x[j].imag=x[j].imag/n;
		    }
	       return;
	    }
	  for(m=0;m<l;m++)
	       {
		for(i=m;i<n;i=i+2*l)
		 {
		     z.imag=m*pisign/l;
		     ce=cexp(z);
		     t.real=x[i+l].real*ce.real-x[i+l].imag*ce.imag;
		     t.imag=x[i+l].real*ce.imag+x[i+l].imag*ce.real;
		     x[i+l].real=x[i].real-t.real;
		     x[i+l].imag=x[i].imag-t.imag;
		     x[i].real=x[i].real+t.real;
		     x[i].imag=x[i].imag+t.imag;
                   }
	       }
	  l=2*l;
	  }
}

