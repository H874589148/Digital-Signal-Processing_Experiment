#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mperpsd(complex x[],int n,int nshift,int nsamp,int iwidow,float ts)
{
/*----------------------------------------------------------------------
 Routine mperpsd:To compute the averaged periodogram by Welch's method.
   Input Parameters:
     n      - Number of data samples
     nshift - Number of samples shift between segments
     nsamp  - Number of samples per segment (must be even)
     x      - Array of complex samples X(0) to X(N-1)
     iwidow - If =1,for rectangular window, not =1,for Hamming window.
   Output Parameters:
     nsection   - Number of segments averaged
     psd    - Real array of power spectral density estimation values
                                       in chapter 11
---------------------------------------------------------------------*/
        float w[128],psdr[4096],psdi[4096],work[4096];
        float pi2,tsv;
        int mfre,k,nsection,j,index;
        pi2=8.*atan(1.);
        tsv=0.0;
        mfre=4096;
        for(k=0;k<n;k++)
            w[k]=0.0;
        for(k=0;k<nsamp;k++)
           {
            if(iwidow==1)
                 continue;
            w[k]=0.538+0.462*cos(pi2*(-.5+(float)(k)/(float)(nsamp)));
            tsv+=w[k]*w[k];
            }
        nsection=(nshift==0)?(n/nsamp):((n-nsamp)/(nsamp-nshift) + 1);
        printf("   total segements=%d\n",nsection);
        for(k=0;k<mfre;k++)
            work[k]=0.;
        for(k=1;k<=nsection;k++)
           {
            printf("   k=%d\n",k);
            for(j=0;j<nsamp;j++)
               {
                index=j+(k-1)*(nsamp-nshift);
                psdr[j]=x[index].real;
                psdi[j]=x[index].imag;
                if(iwidow==1)
                   continue;
                psdr[j]=psdr[j]*w[j];
                psdi[j]=psdi[j]*w[j];
                }
            for(j=nsamp;j<mfre;j++)
               {
                psdr[j]=0.;
                psdi[j]=0.;
                }
            mrelfft(psdr,psdi,mfre,-1);
            for(j=0;j<mfre;j++)
                {
                 psdr[j]=psdr[j]*psdr[j]+psdi[j]*psdi[j];
                 psdr[j]=psdr[j]/(float)(nsamp);
                 work[j]=work[j]+psdr[j];
                 }
            }
/*-------------------------------------------------------------------*/
        tsv=tsv*nsection*ts;
        for(k=0;k<mfre;k++)
           {
            psdr[k]=work[k];
            if(iwidow==1)
               continue;
            psdr[k]=psdr[k]/tsv;
            }
        mpsplot(psdr,psdi,mfre,ts);
        return;
        }

