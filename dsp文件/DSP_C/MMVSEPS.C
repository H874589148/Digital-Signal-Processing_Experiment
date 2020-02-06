#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mmvseps(complex x[],complex ef[],complex eb[],int n,
complex a[],int ip,int *ierror,float ts)
{
/*----------------------------------------------------------------------
   routine MMVSEPS: To complete the minimum variance spectral estimation.
   The Burg algorithm is used for the estimation of the AR parameters.

   Input parameters:
          n  : Number of data samples;
          ip : Order of autoregressive model;
          x  : Array of complex data samples, x(0) through x(n-1);
          ts : Sample interval in seconds (real)
   Output Parameters:
         ep  : Real variable representing driving noise variance;
          a  : Array of complex AR parameters a(0) to a(ip);
       psdr  : real array,power spectrum
    ierror=0 : No error
          =1 : Ep<=0 .

         ef  : complex work array,ef(0) to ef(n-1)
         eb  : complex work array,eb(0) to eb(n-1)
                                      in chapter 12
----------------------------------------------------------------------*/
        complex sum;
        float psdr[512],psdi[512];
        int mfre,k,i;
        float ep,c;
        float *p_ep;
        p_ep=&ep;
        mfre=512;
        marburg(x,a,ef,eb,n,ip,p_ep,ierror);
          printf("    ep=%f\n",ep);
        if(*ierror!=0)
           return;
        a[0].real=1.;
        a[0].imag=0.;
        for(k=0;k<=ip;k++)
           {sum.real=0.;
            sum.imag=0.;
            for(i=0;i<=ip-k;i++)
               {c=(float)(ip+1-k-2*i);
                sum.real+=c*(a[k+i].real*a[i].real+
                             a[k+i].imag*a[i].imag);
                sum.imag+=c*(a[k+i].imag*a[i].real-
                             a[k+i].real*a[i].imag);
                }
            sum.real/=ep;
            sum.imag/=ep;
            psdr[k]=sum.real;
            psdi[k]=sum.imag;
            if(k==0)
               continue;
            psdr[mfre-k]=psdr[k];
            psdi[mfre-k]=-psdi[k];
            }
        for(k=ip+1;k<=mfre-ip-1;k++)
           {psdr[k]=0.;
            psdi[k]=0.;
            }
        mrelfft(psdr,psdi,mfre,-1);
        for(k=0;k<mfre;k++)
            if(psdr[k]<=0)
              {printf(" Stop at routine MMVSEPS \n");
               printf("  Power spectrum becomes infinite or negative!");
               return;
               }
        for(k=0;k<mfre;k++)
            psdr[k]=ts/psdr[k];
        mpsplot(psdr,psdi,mfre,ts);
        return;
        }

