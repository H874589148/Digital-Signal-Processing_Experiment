#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mfirres(float b[],int lb,int n,complex h[])
{
/*----------------------------------------------------------------------
  Routine mfirres : To Obtain Frequence Responce h(exp(jw)) of
                    a FIR System h(z)=b(z)
  The explanation of parameters is the same as subroutine miirres.c
                                        in chapter 2
----------------------------------------------------------------------*/
        complex z,bsum;
        float pi,s,sf,sb;
        int k,i;
        pi=4.*atan(1.);
        s=pi/(float)(n);
        for(k=0;k<n;k++)
	   {
	    sf=s*k;
	    bsum.real=0.;
	    bsum.imag=0.;
	    if(lb>0)
               for(i=1;i<=lb;i++)
		  {
		   sb=sf*i;
                   z.real=cos(sb);z.imag=-sin(sb);
                   bsum.real=bsum.real+b[i]*z.real;
                   bsum.imag=bsum.imag+b[i]*z.imag;
                   }
	    h[k].real=bsum.real+b[0];
            h[k].imag=bsum.imag;
	    }
 }

