#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mphares(complex h[],float phase[],int n,float fs,char filename[])
{
/*----------------------------------------------------------------------
 Routine mphares: To Obtain Phase Response of H(exp(jwk)
 input parameters:
 h   :n dimensioned complex array. the frequency response is stored
       in h(0) to h(n-1).
 n   :the dimension of h and phase.
 fs  :sampling frequency (Hz).
 output parameters:
 phase:n dimensioned real array. the phase-frequency response is stored
       in phase(0) to phase(n-1).
 Note:
     this program will generate a data file named "filename.dat" .
                                       in chapter 2
----------------------------------------------------------------------*/
        FILE *fp;
        float s,x,y;
        int k;
	    s=0.5*fs/n;
        for(k=0;k<n;k++)
           {x=h[k].real;
            y=h[k].imag;
            if(fabs(x)>abs_error)
               phase[k]=atan2(y,x);
            if((fabs(x)<abs_error)&&(fabs(y)<abs_error))
               phase[k]=0.0;
            if((fabs(x)<abs_error)&&(fabs(y)>abs_error)&&(k==0))
               phase[k]=0.0;
            if((fabs(x)<abs_error)&&(fabs(y)>abs_error)&&(k>0))
               if(fabs(h[k-1].real)<abs_error)
                 {phase[k]=0.0;
                  continue;
                  }
               else
                 {if(h[k-1].real>0.0)
                  x=0.0001;
                  else
                     x=-0.0001;
                  phase[k]=atan2(y,x);
                  continue;
                  }
             }
        munwrap(phase,n);
        if((fp=fopen(filename,"w"))==NULL)
	  {printf("cannot open file\n");
           exit(0);
           }
        for(k=0;k<n;k++) fprintf(fp,"%f,%f\n",s*k,phase[k]);
        fclose(fp);
        return;
        }


