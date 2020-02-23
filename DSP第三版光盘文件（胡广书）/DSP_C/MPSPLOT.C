#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mpsplot(float psdr[],float psdi[],int mfre,float ts)
{
/*---------------------------------------------------------------------
   Routine mpsplot: To plot the normalized power spectum curve on the
   normalized frequency axis from -.5 to  +.5 .
        mfre : Points in frequency axis and must be the power of 2.
        ts   : Sample interval in seconds (real).
        psdr : Real array of power spectral density values.
        psdi : Real work array.
                                       in chapter 11,12
--------------------------------------------------------------------*/
        FILE *fp;
        char filename[30];
        int k,m2;
        float pmax,fs,faxis;
        m2=mfre/2;
        for(k=0;k<m2;k++)
           {psdi[k]=psdr[k];
            psdr[k]=psdr[k+m2];
            psdr[k+m2]=psdi[k];
            }
        pmax=psdr[0];
        for(k=1;k<mfre;k++)
            if(psdr[k]>pmax)
               pmax=psdr[k];
        for(k=0;k<mfre;k++)
           {psdr[k]=psdr[k]/pmax;
            if(psdr[k]<=0.0)
               psdr[k]=.000001;
            }
        fs=1./ts;
        fs=fs/(float)(mfre);
        printf("Please input filename:\n");
        scanf("%s",filename);
        if((fp=fopen(filename,"w"))==NULL)
           {printf("cannot open file\n");
            exit(0);
            }
        for(k=0;k<mfre;k++)
           {faxis=fs*(k-m2);
            fprintf(fp,"%f,%f\n",faxis,10.*log10(psdr[k]));
            }
        fclose(fp);
        return;
        }

