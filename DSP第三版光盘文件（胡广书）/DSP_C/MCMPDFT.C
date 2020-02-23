#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mcmpdft(complex x[],complex y[],int n,int isign)
{
/*----------------------------------------------------------------------
  Routinue mcmpdft: Directly to Compute the DFT/IDFT of Complex Data
                   x(n) By DFT definition;  in chapter 3.
  If ISIGN=-1: For Forward Transform;
     ISIGN=1 : For Inverse Transform.
                                      in chapter 3
----------------------------------------------------------------------*/
        complex t,ts,z;
        float pi2;
        int m,k;
        pi2=8.*atan(1.);
        t.real=0.;t.imag=isign*pi2/n;
        ts.real=0.0;
        for(m=0;m<n;m++)
           {y[m]=x[0];
            for(k=1;k<n;k++)
               {ts.imag=t.imag*k*m;
                z=cexp(ts);
                y[m].real+=x[k].real*z.real-x[k].imag*z.imag;
                y[m].imag+=x[k].real*z.imag+x[k].imag*z.real;
                }
            if(isign==1)
              {y[m].real/=n;
               y[m].imag/=n;
               }
            }
        }

