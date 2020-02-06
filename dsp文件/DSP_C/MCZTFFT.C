#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mcztfft(complex* x1,int n,int m,int maxnm,float dltomg,
float omg0,float fs,int *ierror)
{
/*----------------------------------------------------------------------
 Routine CZTFFT:To perform a CHIRP-Z Transform.
 input parameters:
   N     : numbers of input signal to be transformed by CZT,
           x(i),i=0,..,N-1;
   M     : numbers of output signal transformed by CZT,
           x(i),i=0,..,M-1;
 ! Note !: the dimension of x must be MAXNM,otherwise the result
           will be error!
   dltomg: increasing angle of frequncy domain, in Hz;
   omg0  : start angle of CZT, in Hz;
   fs    : sampling frequency in Hz.

 output parameters:
   x    : MAXNM dimensioned complex array. the CZT result is stored
           in x(0) to x(M-1).
   Note  : In this program the largest length to do CZT MAXCZT=1024,
           if you want to increase the length to do CZT please change
           MAXCZT and  the dimension of X,WORK1 and WORK2 .
                                       in Chapter 5
--------------------------------------------------------------------*/
        complex a,z;
        complex x[1024],work1[1024],work2[1024];
        float pi,ph,alpha,ang;
        int nfft,i,ntest,maxczt,m1;
        m1=max(n,m);
        maxczt=1024;
        *ierror=1;
        if(maxnm<m1)
           return;
/*-------------------------------- TO COMPUTE W**(-N**2/2)-----*/
        nfft=n+m;
        for(i=0;i<=10;i++)
           {ntest=pow(2,i);
            if(ntest>=nfft)
               break;
               }
        nfft=ntest;
        *ierror=2;
        if(nfft>maxczt)
           return;
        pi=4.*atan(1.);
        ph=-2.*pi*dltomg/fs;
        for(i=0;i<maxnm;i++)
           {alpha=-ph*i*i/2.;
            work1[i].real=cos(alpha);
            work1[i].imag=sin(alpha);
            work2[i].real=work1[i].real;
            work2[i].imag=work1[i].imag;
            }
        for(i=1;i<n;i++)
           {work1[nfft-i].real=work2[i].real;
            work1[nfft-i].imag=work2[i].imag;
            }
        if(n+m!=nfft)
        for(i=m;i<=nfft-n;i++)
           {work1[i].real=0.;
            work1[i].imag=0.;
            }
        mcmpfft(work1,nfft,-1);
/*------------------------ TO COMPUTE A**(-N)*W**(N**2/2)-----*/
        ang=-omg0*pi*2./fs;
        for(i=0;i<n;i++)
           {a.real=cos(ang*i);
            a.imag=sin(ang*i);
            z.real=work2[i].real*a.real+work2[i].imag*a.imag;
            z.imag=work2[i].real*a.imag-work2[i].imag*a.real;
            x[i].real=z.real*x1[i].real-z.imag*x1[i].imag;
            x[i].imag=z.real*x1[i].imag+z.imag*x1[i].real;
            }
        for(i=n;i<nfft;i++)
           {x[i].real=0.;
            x[i].imag=0.;
            }
        mcmpfft(x,nfft,-1);
/*------------------------ TO COMPUTE g(n)*h(n)---------------*/
        for(i=0;i<nfft;i++)
           {z.real=x[i].real;
            z.imag=x[i].imag;
            x[i].real=z.real*work1[i].real-z.imag*work1[i].imag;
            x[i].imag=z.real*work1[i].imag+z.imag*work1[i].real;
            }
        mcmpfft(x,nfft,1);
/*-------------------------- TO MULTIPLY BY W**(K**2/2)--------*/
        for(i=0;i<m;i++)
           {z.real=x[i].real;
            z.imag=x[i].imag;
            a.real=work2[i].real;
            a.imag=-work2[i].imag;
            x1[i].real=z.real*a.real-z.imag*a.imag;
            x1[i].imag=z.imag*a.real+z.real*a.imag;
            }
        return;
         }

