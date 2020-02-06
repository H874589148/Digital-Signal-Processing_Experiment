#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mdecint(float x[],float h[],float y[],int nh,int ny,int m,
int l,int *k)
{
/*----------------------------------------------------------------------
 Routine mdecint: Using eq. (9.4.33) to implement sampling rate
   conversion by L/M.
 Note: First call routine DEFIR3 to design lowpass  filter, the cutoff
       frequency Wp is given by equation (9.4.26) and the amplitude in
       bandpss should be L,that is,Hd(w)=L,   so we can obtain the
       impulse response  h(n), then call MDECINT to complete needed
       convesion.
  Input parameters:
   x(n):nx dimensioned real array,the data to be converted is stored
             in x(0) to x(n-1);
   h(n):nh dimensioned real array,impulse response is stored in h(0)
             to h(m-1) obtained by call DEFIR3 ;
   m   : factor to decrease sampling freq. (for decimation)
   l   : factor to increase sampling freq. (for interpolation)
 output parameters:
   y(n):ny dimensioned real array, y(n),n=k,...ny-1, have been
            converted data. Generally,ny=nx*L/M
                                      in Chapter 9
---------------------------------------------------------------------*/
        int my,mh,ih,ihl,ihh,ix,tk;
        float t;
        tk=nh/l;
        *k=(l==1)?(nh/m+1):(tk+1);
        for(my=*k;my<ny;my++)
           {
            y[my]=0.;
            for(mh=0;mh<tk;mh++)
               {
                ih=my*m/l;
                ihl=ih*l;
                ihh=my*m+mh*l-ihl;
                ix=ih-mh;
                t=(ix>=0)?x[ix]:0.0;
                y[my]+=h[ihh]*t;
                }
           }
        }

