#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mampres(complex h[],float amp[],int n,float fs,int iamp,
char filename[])
{
/*---------------------------------------------------------------------
 Routine mampres: To obtain amplitude response from h(exp(jw)).
 input parameters:
 h   :n dimensioned complex array. the frequency response is stored
       in h(0) to h(n-1).
 n   :the dimension of h and amp.
 fs  :sampling frequency (Hz).
 iamp:If   iamp=0: The Amplitude Res. amp(k)=abs(h(k));
      If   iamp=1: The Amplitude Res. amp(k)=20.*alog10(abs(h(k))).
 output parameters:
 amp :n dimensioned real array. the amplitude-frequency response is
       stored in amp(0) to amp(n-1).
 Note:
     this program will generate a data file "filename.dat" .
                                        in chapter 2
---------------------------------------------------------------------*/
        FILE *fp;
        float s;
        int k;
        s=0.5*fs/(float)(n);
        for(k=0;k<n;k++)
           {amp[k]=mabs(h[k]);
	    if(amp[k]<0.)
               amp[k]=.000001;
            if(iamp==1)
               amp[k]=20.*log10(amp[k]);
            }
        if((fp=fopen(filename,"w"))==NULL)
          {printf("cannot open file\n");
           exit(0);
           }
        for(k=0;k<n;k++)
            fprintf(fp,"%f,%f\n",s*k,amp[k]);
            fclose(fp);
        return;
        }

