#include "msp.h"
void mcorre1(complex x[],complex y[],complex r[],int n,int lag)
{
/*---------------------------------------------------------------------
  Routine MCORRE1:To estimate the biased cross-correlation function
  of complex arrays x and y. If y=x,then it is auto-correlation.
  input parameters:
     x  :n dimensioned complex array.
     y  :n dimensioned complex array.
     n  :the dimension of x and y.
     lag:point numbers of correlation.
  output parameters:
     r  :lag dimensioned complex array, the correlation function is
         stored in r(0) to r(lag-1).
                                      in Chapter 1 and 11
---------------------------------------------------------------------*/
        int m,j,k;
        for(k=0;k<lag;k++)
	   {
	    m=n-1-k;
            r[k].real=0.0;
            r[k].imag=0.0;
            for(j=0;j<=m;j++)
	       {
		r[k].real+=y[j+k].real*x[j].real+y[j+k].imag*x[j].imag;
                r[k].imag+=y[j+k].imag*x[j].real-y[j+k].real*x[j].imag;
                }
	    r[k].real=r[k].real/n;
	    r[k].imag=r[k].imag/n;
             }
        return;
        }

