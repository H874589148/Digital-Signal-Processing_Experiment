#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mlattic(float b[],float a[],int l,float k[],
float c[],int itype,int *ierror)
{
/*----------------------------------------------------------------------
 Routine mlattic: To converts transfer function coefficients from direct
                 form to lattice form. h(z)=b(z)/a(z)
 input parameters:
   l   : the order of filter;
   b(n): cofficient of b(z),n=0,1,...,l
   a(n): cofficient of a(z),n=1,...,l(a(0)=1.)
 Itype : If itype=0  for FIR system;
         If itype=1  for all-pole IIR system;
         If itype=2  for zero-pole IIR system;
 Note  : When a FIR system will be converted to Lattice form ,first let
         a(z)=b(z), then let h(z)=1/a(z) and call this program;
         If the order of b(z) is smaller than a(z),the surplus of
         b(z) must be given to zero;  For  example: the  order of b(z)
         is 2,the order of a(z) is 3,then b[3]=0;
  Output parameters:
   k(n): lattice cofficient ,n=1,...,l,
   c(n): lattice cofficient ,n=0,1,...,l,
 ierror:    If ierror=0 : conversion with no errors detected;
            if ierror=1 : unstable h(z).
                                      in Chapter 6
--------------------------------------------------------------------*/
        int m,j;
        float work[256][2];
        *ierror=1;
        for (j=0;j<l;j++)
            {k[j]=0;
             c[j]=0;
             }
        work[0][1]=1.;
        for(m=1;m<l;m++)
            work[m][1]=a[m];
        for(m=l-1;m>=1;m-=1)
           {for(j=0;j<=m;j++)
                work[j][2]=work[m-j][1];
                k[m]=-work[m][1];
                if(abs(k[m])>=1.0&&itype!=0)
                   return;
                 for(j=0;j<=m;j++)
                     work[j][1]=(work[j][1]+k[m]*work[j][2])/
                                 (1.-pow(k[m],2));
                 if(itype==2)
                 c[m]=b[m];
                 for(j=0;j<=m;j++)
                   b[j]=b[j]-c[m]*work[j][2];
                 }
            c[0]=b[0];
            *ierror=0;
        return;
        }

