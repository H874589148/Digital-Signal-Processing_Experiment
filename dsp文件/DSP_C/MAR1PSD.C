#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mar1psd(complex a[],int ip,int mfre,float *ep,float ts)
{
/*----------------------------------------------------------------------
   Routine mar1psd: To compute the power spectum by AR-model parameters.
   Input parameters:
          ip : AR model order (integer)
          ep   : White noise variance of model input (real)
          ts   : Sample interval in seconds (real)
          a    : Complex array of AR  parameters a(0) to a(ip)
   Output parameters:
          psdr : Real array of power spectral density values
          psdi : Real work array
                                        in chapter 12
---------------------------------------------------------------------*/
        float psdr[4096],psdi[4096];
        int k;
        float p;
        for(k=0;k<=ip;k++)
           {psdr[k]=a[k].real;
            psdi[k]=a[k].imag;
            }
        for(k=ip+1;k<mfre;k++)
           {psdr[k]=0.;
            psdi[k]=0.;
            }
        mrelfft(psdr,psdi,mfre,-1);
        for(k=0;k<mfre;k++)
           {p=pow(psdr[k],2)+pow(psdi[k],2);
            psdr[k]=(*ep)*ts/p;
            }
        mpsplot(psdr,psdi,mfre,ts);
        return;
        }

