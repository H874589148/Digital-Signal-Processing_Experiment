#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void  miirres(float a[],float b[],int lb,int la,complex h[],int n)
{
/*---------------------------------------------------------------------
 Routinue miirres:to obtain the frequence responce (Amplitude and phase)
     H(exp(jw)) of system  function H(z)=B(z)/A(z);
            b(0)+b(1)z^(-1)+ ... + b(lb)z^(-lb)
       H(z)=------------------------------------
            1.0 +a(1)z^(-1)+ ... + a(la)z^(-la)
 input parameters:
 a :la+1 dimensioned real array. a(0)=1.0,
    a(n) (n=1 to la) is the coef. of z^(-n).
 b :lb+1 dimensioned real array. b(n) (n=0 to la) is the coef. of z^(-n).
 n :data point number of frequency response from 0.0 to pi.the frequency
    resolution is pi/n.
 output parameters:
 H :n dimensioned complex array. frequency response is stored in
    H(0) to H(n-1), which is normalized from 0.0 to pi.
 Note: If H(k)=0/0,then let H(K)=H(k+1) (This is for the case of that
       H(exp(jw)) is a sinc function)
     : If la=0: for FIR system.
                                         in Chapter 2
---------------------------------------------------------------------*/
        complex z,bsum,asum;
        int k,i;
        int isign;
        float pole,peak,pi,s,sf,sa,sb,temp;
        pole=1.e-10;
        peak=1.e+10;
        pi=4.*atan(1.);
        s=pi/(float)(n);
        isign=0;
        for(k=0;k<n;k++)
           {sf=s*k;
            bsum.real=b[0];bsum.imag=0.0;
            if(lb>0)
               for(i=1;i<=lb;i++)
                  {
                  sb=sf*i;
                   z.real=cos(sb);z.imag=-sin(sb);
                   bsum.real+=b[i]*z.real;
                   bsum.imag+=b[i]*z.imag;
                   }
            asum.real=1.;
            asum.imag=0.0;
            if(la!=0)
               for(i=1;i<=la;i++)
                  {sa=sf*i;
                   z.real=cos(sa);z.imag=-sin(sa);
                   asum.real+=a[i]*z.real;
                   asum.imag+=a[i]*z.imag;
                   }
            if(mabs(asum)<pole)
              {
              if(mabs(bsum)<pole)
              isign=1;
              else
              {
              h[k].real=peak;
              h[k].imag=0.0;
              }
              }
            else
              {
              temp=pow(mabs(asum),2.0);
              h[k].real=(bsum.real*asum.real+bsum.imag*asum.imag)/temp;
              h[k].imag=(bsum.imag*asum.real-bsum.real*asum.imag)/temp;
              if(isign==1)
              {
              h[k-1]=h[k];
              isign=0;
              }
              }
         }
        return;
        }

