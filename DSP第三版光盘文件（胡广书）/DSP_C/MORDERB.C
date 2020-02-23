#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void morderb(float *f1,float *f2,float *f3,float *f4,float fs,
float alpha1,float alpha2,int *l,int iband,int itype,int *ierror)
{
/*---------------------------------------------------------------------
  subroutine morderb: To find the order l of lowpass Butterworth AF
  and Chebyshev AF for LP,HP,BP and BS DF by frequence transformation.
   if   iband=1:    lowpass     f1,f2,alpha1,alph2<>0, others=0
             =2:    highpass    f1,f2,alpha1,alph2<>0, others=0
             =3:    bandpass    all not equal zero
             =4:    bandstop    all not equal zero
                                       in Chapter 7
---------------------------------------------------------------------*/
        float pi,omga1,omga2,a1,b1,p,omga3,omga4,omga0,omgar;
        float ada1,ada2,ada3,ada4,ada0,p1,p2,ab;
        *ierror=1;
        if(iband<1||iband>4)return;
        pi=4.*atan(1.);
/*------------------  for low-pass -------------------------*/
        omga1=tan(pi*(*f1)/fs);
        omga2=tan(pi*(*f2)/fs);
        a1=alpha1/10.;
        a1=pow(10.,a1)-1.;
        b1=alpha2/10.;
        b1=pow(10.,b1)-1.;
        p=omga1/omga2;
        if(iband==2)
            {
        /*------------------  for high pass ------------------------*/
                p=omga1/omga2;
                *f1=*f2;
                *f2=0.0;
                printf("  p=%f\n",p);
            }
        if(iband==3)
        {
/*------------------  for band pass ------------------------*/
         omga3=tan(pi*(*f3)/fs);
         omga4=tan(pi*(*f4)/fs);
         *f1=*f2;
         *f2=*f3;
         omgar=omga3-omga2;
         omga0=omga3*omga2;
         omga0=sqrt(omga0);
         ada1=omga1/omgar;
         ada2=omga2/omgar;
         ada3=omga3/omgar;
         ada4=omga4/omgar;
         ada0=omga0/omgar;
         omga1=(ada3*ada3-ada0*ada0)/ada3;
         omga2=(ada4*ada4-ada0*ada0)/ada4;
         p1=omga1/omga2;
         omga1=(ada2*ada2-ada0*ada0)/ada2;
         omga2=(ada1*ada1-ada0*ada0)/ada1;
         p2=omga1/omga2;
         p=p1;
         if(p1<p2) p=p2;
         }
/*-------------------  for band stop -----------------------*/
  if(iband==4)
         {
         omga3=tan(pi*(*f3)/fs);
         omga4=tan(pi*(*f4)/fs);
         *f1=*f1;
         *f2=*f4;
         omgar=omga4-omga1;
         omga0=omga4*omga1;
         omga0=sqrt(omga0);
         ada1=omga1/omgar;
         ada2=omga2/omgar;
         ada3=omga3/omgar;
         ada4=omga4/omgar;
         ada0=omga0/omgar;
         omga1=ada1/(ada1*ada1-ada0*ada0);
         omga2=ada2/(ada2*ada2-ada0*ada0);
         p1=omga1/omga2;
         omga1=ada4/(ada4*ada4-ada0*ada0);
         omga2=ada3/(ada3*ada3-ada0*ada0);
         p2=omga1/omga2;
         p=p1;
         if(p1<p2)
            p=p2;
         }
/*-------------------------------------------------------------------*/
      if(itype==0)
          {ab=(log10(a1)-log10(b1))/log10(p);
           *l=ab/2.+.9;
           }
        else
          {ab=log(sqrt(b1/a1)+sqrt(b1/a1-1))/log(1.0/p
                             +sqrt(1.0/pow(p,2)-1));
           *l=ab+.9;
           }
        *ierror=0;
        printf(" The order of low-pass AF  l=%d\n",*l);
        return;
        }

