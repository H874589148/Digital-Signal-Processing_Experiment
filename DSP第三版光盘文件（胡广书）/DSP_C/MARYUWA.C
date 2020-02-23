#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void maryuwa(complex x[],complex a[],complex r[],int n,int ip,
float *ep,int *ierror)
{
/*---------------------------------------------------------------------
  Routine maryuwa: To determine the autoregressive coefficients by
          solving Yule-Walker equation with Levinson algorithm.
  Input Parameters:
     n     : Number of data samples (integer)
     ip    : Order of autoregressive model
     x     : Array of complex data values, x(0) to x(n-1)
  Output Parameters:
     ep    : Driving noise variance (real)
     a     : Array of complex autoregressive coefficients, a(0) to
             a(ip)
  ierror=0 : No error
        =1 : ep<=0 .

        r  : complex work array, auto-correlation
                                       in chapter 12
--------------------------------------------------------------------*/
        complex sum;
        int i,k;
        float r0;
        *ierror=1;
        mcorre1(x,x,r,n,ip+1);
        a[0].real=1.;
        a[0].imag=0.0;
        r0=r[0].real;
        a[1].real=-r[1].real/r0;
        a[1].imag=-r[1].imag/r0;
        *ep=r0*(1.-pow(mabs(a[1]),2));
        for(k=2;k<=ip;k++)
            {sum.real=0.;
             sum.imag=0.;
             for(i=1;i<k;i++)
                {sum.real+=r[k-i].real*a[i].real-r[k-i].imag*a[i].imag;
                 sum.imag+=r[k-i].real*a[i].imag+r[k-i].imag*a[i].real;
                 }
             sum.real+=r[k].real;
             sum.imag+=r[k].imag;
             a[k].real=-sum.real/(*ep);
             a[k].imag=-sum.imag/(*ep);
             (*ep)*=1.-pow(mabs(a[k]),2);
             if(*ep<=0.0)
                return;
             for(i=1;i<k;i++)
                {x[i].real=a[i].real+a[k-i].real*a[k].real+
                           a[k-i].imag*a[k].imag;
                 x[i].imag=a[i].imag+a[k-i].real*a[k].imag-
                           a[k-i].imag*a[k].real;
                 }
             for(i=1;i<k;i++)
                {a[i].real=x[i].real;
                 a[i].imag=x[i].imag;
                 }
             }
        *ierror=0;
        return;
        }

