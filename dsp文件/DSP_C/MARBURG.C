#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void marburg(complex x[],complex a[],complex ef[],complex eb[],
int n,int ip,float *ep,int *ierror)
{
/*----------------------------------------------------------------------
   Routine marburg: To estimate the AR parameters by Burg algorithm.
   Input Parameters:
          n  : Number of data samples
          ip : Order of autoregressive process
          x  : Array of complex data samples x(0) through x(n-1)
   Output Parameters:
         ep  : Real variable representing driving noise variance
          a  : Array of complex AR parameters a(0) to a(ip)
    ierror=0 : No error
          =1 : ep<=0 .

        ef   : complex work array. ef[0] to ef[n-1]
        eb   : complex work array. eb[0] to eb[n-1]
                                       in chapter 12
----------------------------------------------------------------------*/
        complex sum;
        int i,m;
        float r0,den;
        *ierror=1;
        a[0].real=1.;
        a[0].imag=0.0;
        r0=0.;
        for(i=0;i<n;i++)
           {r0+=pow(mabs(x[i]),2);
            ef[i].real=x[i].real;
            ef[i].imag=x[i].imag;
            eb[i].real=x[i].real;
            eb[i].imag=x[i].imag;
            }
        den=0.0;
        r0/=(float)(n);
        sum.real=0.0;
        sum.imag=0.0;
        for(i=1;i<n;i++)
           {den+=pow(mabs(ef[i]),2)+pow(mabs(eb[i-1]),2);
            sum.real+=ef[i].real*eb[i-1].real+ef[i].imag*eb[i-1].imag;
            sum.imag+=-ef[i].real*eb[i-1].imag+ef[i].imag*eb[i-1].real;
            }
        sum.real*=-2.;
        sum.imag*=-2.;
        a[1].real=sum.real/den;
        a[1].imag=sum.imag/den;
        *ep=r0*(1.-pow(mabs(a[1]),2));
        for(i=n-1;i>=1;i-=1)
           {sum.real=ef[i].real;
            sum.imag=ef[i].imag;
            ef[i].real=sum.real+a[1].real*eb[i-1].real-
                                a[1].imag*eb[i-1].imag;
            ef[i].imag=sum.imag+a[1].real*eb[i-1].imag+
                                a[1].imag*eb[i-1].real;
            eb[i].real=eb[i-1].real+a[1].real*sum.real+
                                a[1].imag*sum.imag;
            eb[i].imag=eb[i-1].imag+a[1].real*sum.imag-
                                a[1].imag*sum.real;
            }
/*-------------------------------------------------------------------*/
        for(m=2;m<=ip;m++)
           {sum.real=0.0;
            sum.imag=0.0;
            for(i=m;i<n;i++)
               {sum.real+=ef[i].real*eb[i-1].real+
                          ef[i].imag*eb[i-1].imag;
                sum.imag+=-ef[i].real*eb[i-1].imag+
                          ef[i].imag*eb[i-1].real;
                }
            sum.real*=-2.;
            sum.imag*=-2.;
            den=(1.-pow(mabs(a[m-1]),2))*den-
                 pow(mabs(ef[m-1]),2)-pow(mabs(eb[n-1]),2);
            a[m].real=sum.real/den;
            a[m].imag=sum.imag/den;
            (*ep)*=1.-pow(mabs(a[m]),2);
            if(*ep<=0) return;
            for(i=1;i<m;i++)
               {x[i].real=a[i].real+a[m].real*a[m-i].real+
                          a[m].imag*a[m-i].imag;
                x[i].imag=a[i].imag-a[m].real*a[m-i].imag+
                          a[m].imag*a[m-i].real;
                }
            for(i=1;i<m;i++)
               {a[i].real=x[i].real;
                a[i].imag=x[i].imag;
                }
            for(i=n-1;i>=m;i-=1)
               {sum.real=ef[i].real;
                sum.imag=ef[i].imag;
                ef[i].real=sum.real+a[m].real*eb[i-1].real-
                           a[m].imag*eb[i-1].imag;
                ef[i].imag=sum.imag+a[m].real*eb[i-1].imag+
                           a[m].imag*eb[i-1].real;
                eb[i].real=eb[i-1].real+a[m].real*sum.real+
                           a[m].imag*sum.imag;
                eb[i].imag=eb[i-1].imag+a[m].real*sum.imag-
                           a[m].imag*sum.real;
                }
          }
        *ierror=0;
        return;
        }

