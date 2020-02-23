#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void marmach(complex x[],complex ef[],int n,complex a[],
complex b[],int ip,int iq,int m,float *ep,float ts)
{
/*----------------------------------------------------------------------
   Routine ARMACH: To estimate the parameters of ARMA(ip,iq) model and
                      estimate the PSD;
   First using the Cholesky decomposition  method to solve eq(12.8.5)
   to find AR model's parameters, this is finished by calling
   subroutine MCHOLSK . Then call subroutine MARYUWA in twice to find
   MA's parameters, this is done as same as subroutine MMAYUWA.

  Input Parameters:
     n     : Number of data samples ;
     x     : Array of complex data values, x(0) to x(n-1)
     rr    : (m-iq+1)*(ip+1) complex auto-correlation matrix, it is
             matrix R of eq.(12.8.5);
     ip    : Order of AR model;
     iq    : Order of MA model ;
      m    : see eq.(12.8.3)
     ts    : Sample interval in seconds (real)
  Output Parameters:
    ep     : Driving noise variance (real)
     b     : Array of complex MA coefficients, b(0) to b(iq)
     a     : Array of complex AR coefficients, a(0) to A(ip)
    ierror : Status indicator.  Returns set to 0 for normal exit,
             else 1 for ill-conditioned.

    ipp    : Order of 'long AR model',it is computed internally
     ef    : complex work array,ef(0) to ef(n-1)
     aa    : complex work array,aa(0),aa(63)
    psdar  : real work array.
    psdbr  : real work array.
    work   : real work array.

                                      in chapter 12
----------------------------------------------------------------------*/
        complex rr[40][40],aa[64];
        float psdbr[1024],psdar[1024],work[1024];
        float pb,eps;
        int nn,mfre,ipp,lag,i,j,l,iflag,k,ierror;
        int *p_iflag;
        p_iflag=&iflag;
        mfre=1024;eps=1.0e-15;
        if(m>63)
           {printf(" Stop at routine MARMACH \n");
            printf(" Please increase the dimensions of array aa\n");
            return;
             }
        nn=m-iq;
        if( (nn>40) || (ip>40))
           {printf(" Stop at routine MARMACH \n");
            printf("  Please increase the dimensions of array rr\n");
            return;
             }
        nn=ip*(ip+1)/2;
        if( (nn>127) || (n>128))
           {printf(" Stop at routine MARMACH \n");
            printf("  Please increase the dimensions of array ab\n");
            return;
             }
        if(ip>=m)
           {printf(" Stop at routine MARMACH \n");
            printf("  Please keep ip<m!\n");
            return;
             }
        if(iq>=m)
           {printf(" Stop at routine MARMACH \n");
            printf("  Please keep iq<m!\n");
            return;
             }
/*------------------------------------------------------------------*/
        lag=m+2;
        mcorre1(x,x,aa,n,lag);
        for(k=0;k<lag;k++)
           {aa[k].real=(float)n*aa[k].real/(float)(n-k);
            aa[k].imag=(float)n*aa[k].imag/(float)(n-k);
            }
/*----  Fill in the (M-IQ)xIP autocorrelation matrix used
                              in the least squares solution --------*/
        for(i=1;i<=m-iq;i++)
           {for(j=1;j<=ip;j++)
               {if(iq+i-j>=0)
                  {rr[i][j].real=aa[iq+i-j].real;
                   rr[i][j].imag=aa[iq+i-j].imag;
                   }
                if(iq+i-j<0)
                  {rr[i][j].real=aa[j-i-iq].real;
                   rr[i][j].imag=-aa[j-i-iq].imag;
                   }
                }
             }
/*------ Compute R^H R matrix and store in symmetric mode (upper
                       triangular part only) ----------------------*/
        l=1;
        for(j=1;j<=ip;j++)
           {for(i=1;i<=j;i++)
               {ef[l].real=0.;
                ef[l].imag=0.;
                for(k=1;k<=m-iq;k++)
                 {ef[l].real+=rr[k][i].real*rr[k][j].real+
                              rr[k][i].imag*rr[k][j].imag;
                  ef[l].imag+=rr[k][i].real*rr[k][j].imag-
                              rr[k][i].imag*rr[k][j].real;
                  }
                l++;
                }
             }
/*----------  Compute -R^H r or right-hand-side vector ------------*/
        for(i=1;i<=ip;i++)
           {a[i].real=0.;
            a[i].imag=0.;
            for(k=1;k<=m-iq;k++)
               {a[i].real-=rr[k][i].real*aa[iq+k].real+
                           rr[k][i].imag*aa[iq+k].imag;
                a[i].imag-=rr[k][i].real*aa[iq+k].imag-
                           rr[k][i].imag*aa[iq+k].real;
                }
             }
/*----------- Solve least squares equations -----------------------*/
        mcholsk(ef,a,ip,eps,p_iflag);
        printf("    iflag=%d\n",iflag);
        if(iflag==-1) return;
        a[0].real=1.0;
        a[0].imag=0.0;
        ef[0].real=x[0].real;
        ef[0].imag=x[0].imag;
        for(i=1;i<=ip;i++)
           {ef[i].real=0.;
            ef[i].imag=0.;
            for(j=0;j<=i;j++)
               {ef[i].real+=a[j].real*x[i-j].real-a[j].imag*x[i-j].imag;
                ef[i].imag+=a[j].real*x[i-j].imag+a[j].imag*x[i-j].real;
                }
            }
        for(i=ip+1;i<n;i++)
           {ef[i].real=0.;
            ef[i].imag=0.;
            for(j=0;j<=ip;j++)
               {ef[i].real+=a[j].real*x[i-j].real-a[j].imag*x[i-j].imag;
                ef[i].imag+=a[j].real*x[i-j].imag+a[j].imag*x[i-j].real;
                }
            }
        for(k=0;k<n;k++)
           {x[k].real=ef[k].real;
            x[k].imag=ef[k].imag;
            }
        ipp=n/5;
        if(ipp>=m) ipp=m;
        maryuwa(x,aa,ef,n,ipp,ep,&ierror);
        if(ierror!=0)
           {printf(" stop at ARYUWA, First call. ierror=%d\n",ierror);
            return;
             }
        printf(" First  call MARYUWA,  white noise variance=%f\n",*ep);
        maryuwa(aa,b,ef,ipp,iq,ep,&ierror);
        if(ierror!=0)
           {printf(" stop at ARYUWA, Second call. ierror=%d\n",ierror);
            return;
             }
      printf(" Second call MARYUWA, white noise variance=%f\n",*ep);
/*-------------------------------------------------------------------*/
        for(k=0;k<=ip;k++)
           {psdar[k]=a[k].real;
            work[k]=a[k].imag;
            }
        for(k=ip+1;k<mfre;k++)
           {psdar[k]=0.;
            work[k]=0.;
            }
        mrelfft(psdar,work,mfre,-1);
        for(k=0;k<mfre;k++)
            psdar[k]=pow(psdar[k],2)+pow(work[k],2);
        for(k=0;k<=iq;k++)
           {psdbr[k]=b[k].real;
            work[k]=b[k].imag;
            }
        for(k=iq+1;k<mfre;k++)
           {psdbr[k]=0.;
            work[k]=0.;
            }
        mrelfft(psdbr,work,mfre,-1);
        for(k=0;k<mfre;k++)
           {pb=pow(psdbr[k],2)+pow(work[k],2);
            psdar[k]=(*ep)*ts*pb/psdar[k];
            }
/*-------------------------------------------------------------------*/
        mpsplot(psdar,psdbr,mfre,ts);
        return;
        }


