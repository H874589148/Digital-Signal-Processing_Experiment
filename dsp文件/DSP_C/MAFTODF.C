#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
int  mspbfct(int i1,int i2)
{
/*-------- generates (i1)!/(i1-i2)!=i1*(i1-1)*...*(i1-i2+1). ----------
-------- note: 0!=1 and spbfct(i,i)=spbfct(i,i-1)=i!.      -----------*/
          int z,i;
          z=0;
          if(i1<0.||i2<0.||i2>i1) return(z);
          z=1;
          if(i2==0) return(z);
          for(i=i1;i>=i1-i2+1;i-=1) z*=i;
          return(z);
        }
/*-------------------------------------------------------------------*/
void maftodf(float d[],float c[],int ln,int iband,
float fln,float fhn,float b[],float a[],int *ierror)
{
/*---------------------------------------------------------------------
 Routine maftodf: To converts normalized LP analog h(s) to digital h(z).
   h(s)=d(s)/c(s),h(z)=b(z)/a(z).Filter order l is computed internally.
   LN specifies coefficient array size. work(0:ln,0:ln) is a work array
   IF   iband=1:    lowpass         fln=normalized cutoff frequency
             =2:    highpass        fln=normalized cutoff frequency
             =3:    bandpass        fln=low  cutoff frequency
                                    fhn=high cutoff frequency
             =4:    bandstop        fln=low  cutoff frequency
                                    fhn=high cutoff frequency
   IF  ierror=0:    no errors detected
              1:    all zero transfer function
              2:    bilin: invalid transfer function
              3:    filter order exceeds array size
              4:    invalid filter type parameter (iband)
              5:    invalid cutoff frequency
       From Ref. [5] of Chapter 2 .
                                       in chapter 7
-----------------------------------------------------------------------*/
        float pi,w1,w2,w,w02,tmp,tmpd,tmpc,z;
        float work[256][20];
        int i,m,mm,l,ll,ls,k;
        pi=4.*atan(1.);
        *ierror=0;
        if(iband<1||iband>4) *ierror=4;
        if(fln<=0.||fln>0.5) *ierror=5;
        if(iband>=3.&&fln>=fhn) *ierror=5;
        if(iband>=3&&fhn>0.5) *ierror=5;
        if(*ierror!=0) return;
        for(i=ln-1;i>=0;i-=1)
            if(c[i]!=0.||d[i]!=0.)
                break;
        if(i<0)
            {
                *ierror=1;
                return;
            }
        m=i;
        w1=tan(pi*fln);
        l=m;
        if(iband>2)
        {
        l=2*m;
        w2=tan(pi*fhn);
        w=w2-w1;
        w02=w1*w2;
        }
        *ierror=3;
        if(l>ln)
           return;
        switch(iband)
        {case 1:
            {
            /*-------- scaling s/w1 for lowpass,highpass -----------------------*/
              for(mm=0;mm<=m;mm++)
                       {z=pow(w1,mm);
                        d[mm]=d[mm]/z;
                        c[mm]=c[mm]/z;
                         }
               break;
               }
         case 2:
              {
            /*-------- substitution of 1/S to generate highpass (hp,bs) --------*/
                  for(mm=0;mm<=m/2;mm++)
                       {tmp=d[mm];
                        d[mm]=d[m-mm];
                        d[m-mm]=tmp;
                        tmp=c[mm];
                        c[mm]=c[m-mm];
                        c[m-mm]=tmp;
                          }
              /*-------- scaling s/w1 for lowpass,highpass -----------------------*/
              for(mm=0;mm<=m;mm++)
                       {z=pow(w1,mm);
                        d[mm]=d[mm]/z;
                        c[mm]=c[mm]/z;
                         }
                break;
                }
         case 3:
            {
            /*-------- substitution of (s**2+w0**2)/(w*s)  bandpass,bandstop ---*/
              for(ll=1;ll<=l+1;ll++)
                       {work[ll][1]=0.;
                        work[ll][2]=0.;
                        }
                    for(mm=0;mm<=m;mm++)
                       {tmpd=d[mm]*pow(w,(m-mm));
                        tmpc=c[mm]*pow(w,(m-mm));
                        for(k=0;k<=mm;k++)
                           {ls=m+mm-2*k;
                            tmp=mspbfct(mm,mm)/(mspbfct(k,k)*mspbfct(mm-k,mm-k));
                            work[ls+1][1]+=tmpd*pow(w02,k)*tmp;
                            work[ls+1][2]+=tmpc*pow(w02,k)*tmp;
                            }
                          }
                    for(ll=0;ll<=l;ll++)
                       {d[ll]=work[ll+1][1];
                        c[ll]=work[ll+1][2];
                        }
                   break;
                 }
         case 4:
            {
            /*-------- substitution of 1/S to generate highpass (hp,bs) --------*/
              for(mm=0;mm<=m/2;mm++)
                       {tmp=d[mm];
                        d[mm]=d[m-mm];
                        d[m-mm]=tmp;
                        tmp=c[mm];
                        c[mm]=c[m-mm];
                        c[m-mm]=tmp;
                          }
            /*-------- substitution of (s**2+w0**2)/(w*s)  bandpass,bandstop ---*/
              for(ll=1;ll<=l+1;ll++)
                       {work[ll][1]=0.;
                        work[ll][2]=0.;
                        }
                    for(mm=0;mm<=m;mm++)
                       {tmpd=d[mm]*pow(w,(m-mm));
                        tmpc=c[mm]*pow(w,(m-mm));
                        for(k=0;k<=mm;k++)
                           {ls=m+mm-2*k;
                            tmp=mspbfct(mm,mm)/(mspbfct(k,k)*mspbfct(mm-k,mm-k));
                            work[ls+1][1]+=tmpd*pow(w02,k)*tmp;
                            work[ls+1][2]+=tmpc*pow(w02,k)*tmp;
                            }
                          }
                    for(ll=0;ll<=l;ll++)
                       {d[ll]=work[ll+1][1];
                        c[ll]=work[ll+1][2];
                        }
               break;
               }
         }
/*---------- substitute (z-1)/(z+1) --------------------------------*/
        mbiline(d,c,ln,b,a,ierror);
        if(*ierror==0) return;
        printf("   stop at routine biline,ierror=%d\n",*ierror);
        return;
        }

