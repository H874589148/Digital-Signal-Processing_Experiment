#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mconvo1(float x[],float h[],float y[],int n,int m,int l)
{
/*--------------------------------------------------------------------
 Routine mconvo1: To implement Linear Convolution y(n)=x(n)*h(n)
 input parameters:
 x(n):L dimensioned real array,signal data is stored in x(0) to x(n-1).
 h(n):L dimensioned real array,impuls response is stored in h(0) to h(m-1).
 n   : the data length of x.
 m   : the data length of h.
 L   : the data length of y, L must be >=n+m-1
 output parameters:
 y(n):L dimensioned real array, y(n)=x(n)*h(n),n=0,...L-1.
                                        in chapter 1
--------------------------------------------------------------------*/
        int i,k;
        float sum;
        for(i=n;i<l;i++)
            x[i]=0.0;
        for(i=m;i<l;i++)
            h[i]=0.0;
            for(k=0;k<l;k++)
	       {
		sum=0.0;
                for(i=0;i<=k;i++)
                     sum+=x[i]*h[k-i];
                y[k]=sum;
                 }
}