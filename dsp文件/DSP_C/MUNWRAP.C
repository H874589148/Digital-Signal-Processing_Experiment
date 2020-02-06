#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void munwrap(float phase[],int n)
{
/*----------------------------------------------------------------------
  Routine munwrap:To unwrap the phase when it is computed by fuction
                 atan(hr,hi);
 input parameters:
   phase:  n dimensioned real array. phase(0) to phase(n-1) are the
           phase value to be unwraped. Note: the phase is in radian.
    n   :  the dimension of array phase.
 output parameters:
   phase:  n dimension real array, phase(0) to phase(n-1) are the
           phase value have been unwraped;
                                      in Chapter 2
----------------------------------------------------------------------*/
        int k;
        float dx;
        float anglejump=0.;
        float angle=4.*atan(1.);
        for(k=1;k<n;k++)
	   {
		dx=phase[k]-(phase[k-1]-anglejump);
		if(sqrt(pow(dx,2))>angle)
			    anglejump-=msign(2.*angle,dx);
          phase[k]+=anglejump;
            }
        return;
        }

