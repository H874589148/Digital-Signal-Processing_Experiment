#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mdefir1(int l,int iband,float fl,float fh,float fs,int iwindow,
float b[],float w[],int *ierror)
{
/*----------------------------------------------------------------------
  Subroutine mdesfir: To Design FIR Filter By Windowed Fourier Series.
  fl:low cut-off frequency. fh:high cut-off(For BP,BS). fl,fh,fs in Hz
  Digital filter coefficients are returned in b(l)
                h(z)=b(0)+b(1)z^(-1)+ ... +b(l-1)z^(-l+1)
  Input parameters:
   l    : the length of FIR filter.  l must be odd.
   iband:  iband=1 low  pass FIR filter.
           iband=2 high pass FIR filter.
           iband=3 band pass FIR filter.
           iband=4 band stop FIR filter.
   fln,fhn: the edge frequency desired,in normalized form,0.<=fln,fhn<=.5
          |---        |   ---       |   ---           |--      --
          |   |       |  |          |  |   |          |  |    |
          |   |       |  |          |  |   |          |  |    |
        --|------    -|--------    -|-----------    --|--------------
          0  fln      0  fln        0 fln  fhn        0  fln  fhn
             fhn=*       fhn=*
        iband=1 LP    iband=2 HP      iband=3 BP        iband=4 BS
  iwindow: window type desired.
           iwindow=1: rectangular window ,   =2: triangular window ,
                  =3: cosin window ,         =4: Hanning window ,
                  =5: Hamming window ,       =6: Blackman window ,
                  =7: Papoulis window .
        w: l dimensioned real work array.
  Output parameters:
   b: l dimensioned real array.the result is in b(0) to b(l-1).
   ierror: ierror=0:      no errors detected
                 =1:      invalid length  (l<=0)
                 =2:      invalid window type
                 =3:      invalid filter type
                 =4:      invalid cut-off frequency
                                      in Chapter 8
-----------------------------------------------------------------------*/
        float pi,fln,fhn,wc1,wc2,s;
        int lim,i;
        float dly;
        pi=4.*atan(1.);
        fln=fl/fs;
        fhn=fh/fs;
        for(i=0;i<l;i++) b[i]=0.;
        *ierror=0;
	    dly=l/2.;
        lim=l/2;
        if(dly==(float)lim) *ierror=1;
        if(iwindow<1||iwindow>7) *ierror=2;
        if(iband<1||iband>4) *ierror=3;
        if(fln<0.||fln>0.5) *ierror=4;
        if(iband>=3&&fln>=fhn) *ierror=4;
        if(iband>=3&&fhn>=0.5) *ierror=4;
        if(*ierror!=0) return;
        dly-=.5;
        lim-=1;
        wc1=2.*pi*fln;
        if(iband>=3) wc2=2.*pi*fhn;
        mwindow(w,l,iwindow,ierror);
        switch (iband)
    	{
        	/*Low pass */
        	 case 1:
        	       {
        		 for(i=0;i<=lim;i++)
        		    {
        		     s=i-dly;
        		     b[i]=((sin(wc1*s))/(pi*s));
        		     b[i]=b[i]*w[i];
        		     b[l-1-i]=b[i];
        		     }
        		 b[(l-1)/2]=wc1/pi;
        		 return;
        	       }
                 /*High pass */
        	 case 2:
        		   {
        		    for(i=0;i<=lim;i++)
        		     {s=i-dly;
        		      b[i]=((sin(pi*s)-sin(wc1*s))/(pi*s));
        		      b[i]=b[i]*w[i];
        		      b[l-1-i]=b[i];
        		      }
        		     b[(l-1)/2]=1.-wc1/pi;
        		     return;
        		   }
                 /*band pass */
        	 case 3:
        		     {
        		       for(i=0;i<=lim;i++)
        		       {s=i-dly;
        			b[i]=((sin(wc2*s)-sin(wc1*s))/(pi*s));
        			b[i]=b[i]*w[i];
        			b[l-1-i]=b[i];
        			}
        			b[(l-1)/2]=(wc2-wc1)/pi;
        			return;
        		     }
                 /*band stop */
        	 case 4:
        		      {
        		       for(i=0;i<=lim;i++)
        			     {s=i-dly;
        			      b[i]=((sin(wc1*s)+sin(pi*s)-sin(wc2*s))/(pi*s));
        			      b[i]=b[i]*w[i];
        			      b[l-1-i]=b[i];
        			      }
        			  b[(l-1)/2]=(wc1+pi-wc2)/pi;
        			  return;
        		      }
                 default:break;
    	 }
}

