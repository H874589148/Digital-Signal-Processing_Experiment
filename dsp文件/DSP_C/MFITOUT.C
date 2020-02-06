#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void  mfitout(float b[],float a[],int lb,int la,float x[],int n,
float y[])
{
/*----------------------------------------------------------------------
 Routine mfitout: To Obtain Output of IIR or FIR filter;
 System is in form h(z)=b(z)/a(z)
            b(0)+b(1)z^(-1)+ ... + b(lb)z^(-lb)
       h(z)=------------------------------------
            1.0 +a(1)z^(-1)+ ... + a(la)z^(-la)
 If la=0: For FIR system.
 If x(0)=1,x(n)=0 for n>0,the output is the impulse response h(n).
 input parameters:
 b :lb+1 dimensioned real array. b(n) (n=0 to la) is the coef of z^(-n).
 a :la+1 dimensioned real array. a(0)=1.0,
    a(n) (n=1 to la) is the coef of z^(-n).
 n :data point number of input and output signal.
 x :n dimensioned real array.input signal is stored in x(0) to x(n-1).
 output parameters:
 y :n dimensioned real array. output signal is stored in y(0) to y(n-1).
                                          in Chapter 2
---------------------------------------------------------------------*/
        int k,i,ki;
        float sum;
        for(k=0;k<n;k++)
           {
            sum=0.0;
            for(i=0;i<=lb;i++)
               {
                ki=k-i;
                if(ki<0)break;
                if(fabs(b[i])<abs_error||fabs(x[ki])<abs_error)continue;
                sum=sum+b[i]*x[ki];
                if(sum>1.e10)exit(3);
                }
       if(la!=0)
              for(i=1;i<=la;i++)
                {
                 ki=k-i;
                 if(ki<0)break;
         if(fabs(a[i])<abs_error)continue;
                  sum=sum-a[i]*y[ki];
          if(sum>1.e10)exit(3);
                 }
             y[k]=sum;
            }
        }

