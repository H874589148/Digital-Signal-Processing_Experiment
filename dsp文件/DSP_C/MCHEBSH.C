#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mchebsh(int l,int k,int ln,float d[],float c[],float phi2,
int *ierror)
{
/*---------------------------------------------------------------------
    routine mchebsh: To design low-pass Chebyshev analog filter:
                        H(s)=D(s)/C(s)
       If ierror=0: no errors detected
                =1: invalid filter order l
                =2: invalid section number k
                                        in chapter 7
--------------------------------------------------------------------*/
        float pi;
        int i;
        pi=4.*atan(1.);
        *ierror=0;
        if(l<=0)
           *ierror=1;
        if(k<=0||k>l)
           *ierror=2;
        if(*ierror!=0)
           return;
        for(i=1;i<ln;i++)
           {d[i]=0.;
            c[i]=0.;
             }
        d[0]=1.0;
        c[0]=1.0;
        if(k-(l+1.)/2==0)
          {c[0]=(exp(phi2)-exp(-phi2))/2.0;
           c[1]=1.0;
           }
        else
       {c[0]=pow(sin((2*k-1)*pi/(2*l))*(exp(phi2)-exp(-phi2))/2.0,2)
             +pow(cos((2*k-1)*pi/(2*l))*(exp(phi2)+exp(-phi2))/2.0,2);
        c[1]=2.*sin((2*k-1)*pi/(2*l))*(exp(phi2)-exp(-phi2))/2.0;
        c[2]=1.;
             }
        return;
        }

