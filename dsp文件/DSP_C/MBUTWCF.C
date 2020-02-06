#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mbutwcf(int l,int k,int ln,float d[],float c[],int *ierror)
{
/*---------------------------------------------------------------------
    routine mbutwcf: To design low-pass Butterworth analog filter:
                    H(s)=C(s)/D(s) ,
       If ierror=0: no errors detected
                =1: invalid filter order l
                =2: invalid section number k
                                        in Chapter 7
--------------------------------------------------------------------*/
        float pi,tmp;
        int i;
        pi=4.*atan(1.);
        *ierror=0;
        if(l<=0)
           *ierror=1;
        if(k<=0||k>(l+1)/2)
           *ierror=2;
        if(*ierror!=0)
           return;
        d[0]=1.;
        c[0]=1.;
        for(i=1;i<ln;i++)
           {d[i]=0.;
            c[i]=0.;
            }
        tmp=k-(l+1)/2.;
        if(tmp==0.)
           c[1]=1.;
        else
        { c[1]=(-2.)*cos((2*k+l-1)*pi/(2*l));
          c[2]=1.;
          }
 }

