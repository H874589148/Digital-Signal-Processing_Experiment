#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mmayuwa(complex x[],int n,complex a[],int ip,
complex b[],int iq,complex r[],float *ep,float ts,int *ierror)
{
/*----------------------------------------------------------------------
  Routine mmayuwa: To determine the MA model coefficients by 
          solve Yule-Walker equation with Levinson algorithm twice.
  Input Parameters:
     n     : Number of data samples ;
     x     : Array of complex data values, x(0) to x(n-1)
     iq-1  : Order of MA process to be fitted ;
     ts    : Sample interval in seconds (real)
  Output Parameters:
    ep     : Driving noise variance (real)
     b     : Array of complex MA coefficients, b(0) to b(iq-1)
   ierror : Status indicator.  Return  0 for normal exit,
             else 1 for ill-condition.
                                       in chapter 12
---------------------------------------------------------------------*/
        float psdr[4096],psdi[4096];
        float p;
        int mfre,k;
        mfre=4096;
        maryuwa(x,a,r,n,ip,ep,ierror);
        if(*ierror!=0)
          {printf(" stop at rotine maryuwa, First call. ierror=%d\n",*ierror);
           printf("   white noise variance=%f\n",*ep);
           return;
           }
        else
          {maryuwa(a,b,r,ip+1,iq,ep,ierror);
           if(*ierror!=0)
             {printf(" stop at rotine aryuwa, Second call.ierror=%d\n",*ierror);
              return;
              }
            }
/*----------------------------------------------------------------------*/
        for(k=0;k<=iq;k++)
           {psdr[k]=b[k].real;
            psdi[k]=b[k].imag;
            }
        for(k=iq+1;k<mfre;k++)
           {psdr[k]=0.;
            psdi[k]=0.;
            }
        mrelfft(psdr,psdi,mfre,-1);
        for(k=0;k<mfre;k++)
           {p=pow(psdr[k],2)+pow(psdi[k],2);
            psdr[k]=(*ep)*ts*p;
            }
/*----------------------------------------------------------------------*/
        mpsplot(psdr,psdi,mfre,ts);
        return;
        }

