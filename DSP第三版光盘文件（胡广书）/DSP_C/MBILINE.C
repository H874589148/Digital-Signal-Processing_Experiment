#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mbiline(float d[],float c[],int ln,
                float b[],float a[],int *ierror)
{
/*--------------------------------------------------------------------
 Routine mbiline: To convert analog h(s) to digital h(z) via bilinear
                 transformation. h(s)=d(s)/c(s), h(z)=b(z)/a(z)
 ln specifies the length of the coefficient arrays and filter order L
 is computed internally.   work is an internal array (2d)
   IF  ierror=0:    no errors detected in transformation
             =1:    all zero transfer function
             =2:    invalid transfer function; y(k) coef=0
       From Ref. [5] of Chapter 2 .
                                       in chapter 7
--------------------------------------------------------------------*/
        int i,l,j;
        float tmp,atmp,scale;
        float work[256][20];
        for(i=ln-1;i>=0;i--)
            if(fabs(c[i])>abs_error||fabs(d[i])>abs_error)
                break;
        
        if(i<0)
            {
                *ierror=1;
                return;
            }
        l=i;
        for(j=0;j<=l;j++)
            work[0][j]=1.;
        tmp=1.;
        for(i=1;i<=l;i++)
            {tmp=tmp*(float)(l-i+1)/(float)(i);
               work[i][0]=tmp;
               }
        for(i=1;i<=l;i++)
            for(j=1;j<=l;j++)
                work[i][j]=work[i][j-1]-work[i-1][j]-work[i-1][j-1];
        for(i=l;i>=0;i-=1)
            {b[i]=0.;
                atmp=0.;
                for(j=0;j<=l;j++)
                   {b[i]+=work[i][j]*d[j];
                        atmp+=work[i][j]*c[j];
                        }
                scale=atmp;
                if(i!=0)
                        a[i]=atmp;
                }
          *ierror=2;
          if(scale==0.) return;
          b[0]=b[0]/scale;
          for(i=1;i<=l;i++)
             { b[i]=b[i]/scale;
                  a[i]=a[i]/scale;
                  }
          for(i=l+1;i<ln;i++)
              { b[i]=0.0;
                   a[i]=0.0;
                  }
         *ierror=0;
         return;
         }

