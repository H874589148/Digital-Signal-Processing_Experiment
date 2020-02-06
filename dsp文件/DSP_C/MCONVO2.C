#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mconvo2(complex x[],complex h[],complex y[],int n1,int n2,int n)
{
/*--------------------------------------------------------------------
  Routine mconvo2: To Compute the Convolution of x(i) and h(i) by DFT.
  x(i),i=0,...,n1-1; h(n),i=0,...,n2-1,But the dimension n of x,h,y
       must be >=(n1+n2-1) and be the power of 2 ;
 input parameters:
 x(n):l dimensioned real array,signal data is stored in x(0) to x(n1-1).
 h(n):l dimensioned real array,impulse response is stored in h(0) to h(n2-1).
 n1  : the data length of x.
 n2  : the data length of h.
 n   : the data length of y, n must be greater than n1 and n2.
 output parameters:
 y(n):n dimensioned real array, y(n)=x(n)*h(n),n=0,...L-1.
 Notes:
     n must be a power of 2.
                                      in chapter 3
--------------------------------------------------------------------*/
        int k,i,nn;
        for(i=1;i<=16;i++)
           {nn=pow(2,i);
	    if(n==nn)break;
	    }
	if(i>16)
	{
	 printf(" N is not a power of 2 ! \n");
	 return;
	}
	for(i=n1;i<n;i++)
            x[i].real=0.0;
        for(i=n2;i<n;i++)
            h[i].real=0.0;
        mcmpfft(x,n,-1);
        mcmpfft(h,n,-1);
        for(k=0;k<n;k++)
           {y[k].real=x[k].real*h[k].real-x[k].imag*h[k].imag;
            y[k].imag=x[k].real*h[k].imag+x[k].imag*h[k].real;
            }
        mcmpfft(y,n,1);
 }

