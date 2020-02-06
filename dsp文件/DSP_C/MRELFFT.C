#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mrelfft(float xr[],float xi[],int n,int isign)
{
/*----------------------------------------------------------------------
  routinue mrelfft:To perform  split-radix DIF fft algorithm.

  input parameters:
   xr,xi:real and image part of complex data for DFT/IDFT,n=0,...,N-1
   N    :Data point number of DFT compute .
   isign:Transform direction disignator ,
               isign=-1: For Forward Transform.
               isign=+1: For Inverse Transform.

  output parameters:
   xr,xi:real and image part of complex result of DFT/IDFT,n=0,...,N-1

  Note: N  must be a power of 2 .
                                       in chapter 5
---------------------------------------------------------------------*/
        float e,es,cc1,ss1,cc3,ss3,r1,s1,r2,s2,s3,xtr,xti,a,a3;
        int m,n2,n4,j,k,is,id,i0,i1,i2,i3,n1,i,nn;
        for(m=1;m<=16;m++)
           {
            nn=pow(2,m);
            if(n==nn)break;
            }
        if(m>16)
            {
                printf(" N is not a power of 2 ! \n");
                return;
            }
        n2=n*2;
        es=-isign*atan(1.0)*8.0;
        for(k=1;k<m;k++)
         {
            n2=n2/2;
            n4=n2/4;
            e=es/n2;
            a=0.0;
            for(j=0;j<n4;j++)
             {
                a3=3*a;
                cc1=cos(a);
                ss1=sin(a);
                cc3=cos(a3);
                ss3=sin(a3);
                a=(j+1)*e;
                is=j;
                id=2*n2;
                do
                   {    
                     for(i0=is;i0<n;i0+=id)
                           {i1=i0+n4;
                            i2=i1+n4;
                            i3=i2+n4;
                            r1=xr[i0]-xr[i2];
                            s1=xi[i0]-xi[i2];
                            r2=xr[i1]-xr[i3];
                            s2=xi[i1]-xi[i3];
                            xr[i0]+=xr[i2];
                            xi[i0]+=xi[i2];
                            xr[i1]+=xr[i3];
                            xi[i1]+=xi[i3];
                            if(isign!=1)
                                {
                                    s3=r1-s2;
                                    r1=r1+s2;
                                    s2=r2-s1;
                                    r2=r2+s1;
                                }
                            else
                                {
                                    s3=r1+s2;
                                    r1=r1-s2;
                                    s2=-r2-s1;
                                    r2=-r2+s1;
                                }
                            xr[i2]=r1*cc1-s2*ss1;
                            xi[i2]=-s2*cc1-r1*ss1;
                            xr[i3]=s3*cc3+r2*ss3;
                            xi[i3]=r2*cc3-s3*ss3;
                            }
                        is=2*id-n2+j;
                        id=4*id;
                        }while(is<n-1);
           }
       }
/*   ------------ special last stage -------------------------*/
        is=0;
        id=4;
        do
        { 
        for(i0=is;i0<n;i0+=id)
           {i1=i0+1;
            xtr=xr[i0];
            xti=xi[i0];
            xr[i0]=xtr+xr[i1];
            xi[i0]=xti+xi[i1];
            xr[i1]=xtr-xr[i1];
            xi[i1]=xti-xi[i1];
            }
        is=2*id-2;
        id=4*id;
        }while(is<n-1);
        j=1;
        n1=n-1;
        for(i=1;i<=n1;i++)
           {
            if(i<j)
                {
                    xtr=xr[j-1];
                    xti=xi[j-1];
                    xr[j-1]=xr[i-1];
                    xi[j-1]=xi[i-1];
                    xr[i-1]=xtr;
                    xi[i-1]=xti;
                }
      k=n/2;
     while(1)
              {
                if(k>=j)break;
                j=j-k;
                k=k/2;
              }
      j=j+k;
            }
        if(isign==-1)return;
        for(i=0;i<n;i++)
           {xr[i]/=n;
            xi[i]/=n;
            }
        return;
        }

