#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mcorpsd(complex x[],complex r[],int n,int lag,int iwindow,float t)
{
/*--------------------------------------------------------------------
   Routine mcorpsd: To compute the power spectrum by auto-correlation
                     method (Blackman-Tukey method).
   Input Parameters:
     x : Array of complex data samples from 0 to n-1
     n   : Number of data samples
     mfre: Data number of power spectrum
     lag : the highest lag index to compute
   Output Parameters:
     r(m):Array of complex correlation from 0 to Lag-1
                                        in chapter 11
---------------------------------------------------------------------*/
        float psdr[4096],psdi[4096];
        int mfre,k;
        float pi2,s,w,t1;
        mfre=4096;
        mcorre1(x,x,r,n,lag);
        pi2=8.*atan(1.);
        s=pi2/(float)(2*lag);
        for(k=0;k<lag;k++)
           {psdr[k]=r[k].real;
            psdi[k]=r[k].imag;
            if(iwindow==1)
               continue;
            w=0.54+0.46*cos(s*k);
            psdr[k]=psdr[k]*w;
            psdi[k]=psdi[k]*w;
            }
        for(k=1;k<lag;k++)
           {psdr[mfre-k]=psdr[k];
            psdi[mfre-k]=-psdi[k];
            }
        for(k=lag;k<=mfre-lag;k++)
           {psdr[k]=0.;
            psdi[k]=0.;
            }
        mrelfft(psdr,psdi,mfre,-1);
        for(k=0;k<mfre;k++)
            psdr[k]=psdr[k]*psdr[k]+psdi[k]*psdi[k];
        t1=t;
        mpsplot(psdr,psdi,mfre,t1);
        return;
        }

