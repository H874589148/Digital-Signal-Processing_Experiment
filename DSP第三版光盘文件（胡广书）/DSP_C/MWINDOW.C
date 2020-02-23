#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mwindow(float w[],int n,int iwindow,int *ierror)
{
/*----------------------------------------------------------------------
  Routine mwindow: To Obtain Window Function.
  Input parameters:
   n      : the length of window data.
   iwindow: window type desired.
   if     : iwindow=1: rectangular window ,  =2: triangular window ,
                   =3: cosin window ,        =4: Hanning window ,
                   =5: Hamming window ,      =6: Blackman window ,
                   =7: Papoulis window .
  Output parameters:
   w: n dimension real array.the result is in w(0) to w(n-1).
   ierror:if ierror=0: no error,    =1: Iwindow out of range.
                                      in Chapter 8
--------------------------------------------------------------------*/
        float pi,pn,a,b,c;
        int i;
        *ierror=1;
        if(iwindow<1) return;
        *ierror=0;
        pi=4.*atan(1.);
        pn=2.*pi/(float)(n);
        switch (iwindow)
	    {
	            case 1:for(i=0;i<n;i++)
		       w[i]=1.0;
		       break;
                case 2:for(i=0;i<n;i++)
		       w[i]=1.-fabs(1.-2.*i/(float)(n));
		       break;
                case 3:for(i=0;i<n;i++)
		       w[i]=sin(pn*i/2.);
		       break;
                case 4:for(i=0;i<n;i++)
		       w[i]=0.5*(1.0-cos(pn*i));
		       break;
                case 5:for(i=0;i<n;i++)
		       w[i]=0.54-0.46*cos(pn*i);
		       break;
                case 6:for(i=0;i<n;i++)
		       w[i]=0.42-0.5*cos(pn*i)+0.08*cos(2.*pn*i);
		       break;
                case 7:for(i=0;i<n;i++)
                          {a=fabs(sin(pn*i))/pi;
                           b=1.-2.*(fabs(i-n/2.))/(float)(n);
                           c=cos(pn*i);
                           w[i]=a-b*c;
                           }
    		}
     }

