#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mprgfft(complex x[],int n,int l,int lf,int k1,int isign)
{
/*----------------------------------------------------------------------
  Routinue mprgfft:to perform an fft algorithm with pruning both in
   input and output. In output side the transfomed data points is from
   k1 to k2,k2=k1+lf-1, lf is the lenghth.
 input parameters:
   x : complex data,for i=0,1, ... ,l-1 x(i) is nonzero.
   n : points numbers to complete DFT ,N>l,
   lf: Length of output data .
   k1: start data point of output .
   isign:if isign=-1 For Forward Transform
         if isign=+1 For Inverse Transform.
 output parameters:
   x : complex array,x(k1) to x(k1+lf-1) is DFT's result .
 Notes:
   n and l must be a power of 2 . Otherwise the result will be error.
   nx,ny : work array
                                       in Chapter 5
---------------------------------------------------------------------*/
        float nx[16],ny[16];
        complex xt;
        float arg,wt,c,s,t1,t2;
        int k2,ntemp,m,l5,lf2,j,n1,i,k,np,j1,j2,ntm1,ntm2,ntm3;
        int i1,nr,nbtf,nd,flg,ns,nn;
        for(m=1;m<=16;m++)
           {nn=pow(2,m);
            if(n==nn)break;
            }
        if(m>16)
        {
            printf(" N is not a power of 2 ! \n");
            return;
        }
       for(l5=1;l5<=15;l5++)
           {n1=pow(2,l5);
            if(l==n1)break;
            }
        if(l5>15)
        {
        printf(" L is not a power of 2 ! \n");
        return;
        }
        for(lf2=1;lf2<=15;lf2++)
           {n1=pow(2,lf2);
	    if(lf==n1) break;
            }
        if(lf2>15)
        {
        printf(" LF is not a power of 2 ! \n");
        return;
        }
        k2=k1+lf-1;
        ntemp=n;
        l5=log((float)(l))/log(2.0);
        lf2=log((float)(lf))/log(2.0);
/*---------- digital reverse loops --------------------------------*/
        j=1;
        n1=ntemp-1;
        for(i=1;i<=n1;i++)
           {
              if(i<j)  
                 {
                    xt.real=x[j-1].real;
                    xt.imag=x[j-1].imag;
                    x[j-1].real=x[i-1].real;
                    x[j-1].imag=x[i-1].imag;
                    x[i-1].real=xt.real;
                    x[i-1].imag=xt.imag;
                  }
                k=n/2;
                  do
                    {   
                      if(k>=j)break;
                            j=j-k;
                            k=k/2;
                        }while(1);
                 j=j+k;
            }
/*-------------------------------------------------------------------*/
        np=pow(2,(m-l5));
        if(l!=m)
            {   
                n1=pow(2,l5);
                j1=n1*np;
                for(i=1;i<=j1;i+=np)
                   for(j=1;j<np;j++)
                       {
                        j2=i+j;
                        x[j2-1].real=x[i-1].real;
                        x[j2-1].imag=x[i-1].imag;
                        }
            }
        ntm1=k1-1;
        ntm2=ntemp;
        ntm3=k2-1;
        i1=max(lf2,m-l5)+1;
        for(i=m;i>=i1;i-=1)
           {ntm2=ntm2/2;
            ntm1=ntm1%ntm2;
            ntm3=ntm3%ntm2;
            ny[i]=ntm3+1;
            nx[i]=ntm1+1;
            }
        nr=np;
        for(i=m-l5+1;i<=m;i++)
           {nbtf=nr;
            nr=2*nr;
            arg=atan(1.)*8.0/nr;
            nd=nbtf;
            ns=1;
            if(i>lf)
            {
            ns=nx[i];
            nd=ny[i];
            }
            if(nd<ns)
            {
            flg=1;
            nd=nbtf;
            }
         for(j=ns;j<=nd;j++)
             {
                wt=arg*(j-1);
                c=cos(wt);
                s=sin(wt)*(0-isign);
                for(k=j;k<=ntemp;k+=nr)
                 {  
                    j2=k+nbtf;
                    t1=c*x[j2-1].real+s*x[j2-1].imag;
                    t2=-s*x[j2-1].real+c*x[j2-1].imag;
                    x[j2-1].real=x[k-1].real-t1;
                    x[j2-1].imag=x[k-1].imag-t2;
                    x[k-1].real+=t1;
                    x[k-1].imag+=t2;
                  }
              }
            if(flg==0) continue;
            flg=0;
            ns=1;
            nd=ny[i];
      }
  return;
}

