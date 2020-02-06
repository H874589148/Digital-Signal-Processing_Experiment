#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mcholsk(complex a[],complex b[],int n,float eps,int *iflag)
{
/*---------------------------------------------------------------------
   Subroutine MCHOLSK :To solves a hermitian positive definite set of
   complex linear simultaneous equations (AX=B) using the Cholesky
   decomposition  method. See Eq. (12.6.23)

   Input Parameters:
     N     - Order of the matrix (number of linear equations)
     EPS   - Small positive number to test for ill-
             conditioning of matrix A
     A     - Complex array of dimension N*(N+1)/2 of matrix
             elements stored columnwise for upper triangular part,
             i.e., A(1,1) stored as A(1), A(1,2) stored as A(2),
             A(2,2) stored as A(3),etc. (The lower triangular part
             is found by hermitian symmetry.)
     B     - Complex array of dimension N*1 of right-hand-side
             vector elements

   Output Parameters:
     IFLAG - Ill-conditioning indicator
               =  0 for normal program termination
               = -1 if one of the di's is less than EPS
                    causing premature termination
     B     - Complex array of dimension N*1 containing solution
             X vector stored in place of B on output
                                       in Chapter 12
---------------------------------------------------------------------*/
        complex xl[31][31],y[31];
        complex t1,t2,t3;
        float d[31];
        int l,i,j,k;
        if(n>30)
           {printf(" Stop at routine MCHOLSK \n");
            printf(" Please increase the dimensions of XL,Y and D\n");
            return;
             }
/*C   Factor into triangular and diagonal form */
        *iflag=0;
        for(i=1;i<=n;i++)
           {for(j=1;j<=n;j++)
               {xl[i][j].real=0.0;
                xl[i][j].imag=0.0;
                }
            }
        l=1;
        d[1]=a[l].real;
        for(i=2;i<=n;i++)
           {for(j=1;j<i;j++)
               {l++;
                xl[i][j].real=a[l].real/d[j];
                xl[i][j].imag=-a[l].imag/d[j];
                if(j==1)
                   continue;
                for(k=1;k<j;k++)
                   {t1.real=xl[i][k].real;
                    t1.imag=xl[i][k].imag;
                    t2.real=xl[j][k].real;
                    t2.imag=xl[j][k].imag;
                    t3.real=t1.real*t2.real+t1.imag*t2.imag;
                    t3.imag=-t1.real*t2.imag+t1.imag*t2.real;
                    xl[i][j].real-=t3.real*d[k]/d[j];
                    xl[i][j].imag-=t3.imag*d[k]/d[j];
                    }
                 }
            l++;
            d[i]=a[l].real;
            for(k=1;k<i;k++)
                d[i]-=d[k]*pow(mabs(xl[i][k]),2);
/*C   Test for non-positive value of di*/
            if(sqrt(pow(d[i],2))>eps)
               continue;
            *iflag=-1;
            return;
            }
/*C   Solve for intermediate column vector solution (2.53)*/
        y[1].real=b[1].real;
        y[1].imag=b[1].imag;
        for(k=2;k<=n;k++)
           {y[k].real=b[k].real;
            y[k].imag=b[k].imag;
            for(j=1;j<k;j++)
               {y[k].real-=xl[k][j].real*y[j].real-
                           xl[k][j].imag*y[j].imag;
                y[k].imag-=xl[k][j].real*y[j].imag+
                           xl[k][j].imag*y[j].real;
                }
            }
/*C   Solve for final column vector solution (2.54)*/
        b[n].real=y[n].real/d[n];
        b[n].imag=y[n].imag/d[n];
        for(k=n-1;k>=1;k--)
           {b[k].real=y[k].real/d[k];
            b[k].imag=y[k].imag/d[k];
            for(j=k+1;j<=n;j++)
               {b[k].real-=xl[j][k].real*b[j].real+
                           xl[j][k].imag*b[j].imag;
                b[k].imag-=-xl[j][k].imag*b[j].real+
                            xl[j][k].real*b[j].imag;
                }
              }
        return;
        }

