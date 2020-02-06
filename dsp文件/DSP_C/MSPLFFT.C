#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void msplfft(complex x[],int n,int isign)
{
/*----------------------------------------------------------------------
 Routine msplfft:to perform the split-radix DIF fft algorithm.
 input parameters:
 x : complex array.input signal is stored in x(0) to x(n-1).
 n : the dimension of x.
 isign:if isign=-1 For Forward Transform
       if isign=+1 For Inverse Transform.
 output parameters:
 x : complex array. DFT result is stored in x(0) to x(n-1).
 Notes:
     n must be power of 2.
                                        in chapter 5
----------------------------------------------------------------------*/
        complex xt;
        float es,e,a,a3,cc1,ss1,cc3,ss3,r1,r2,s1,s2,s3;
        int m,n2,k,n4,j,is,id,i1,i2,i3,i0,n1,i,nn;
        for(m=1;m<=16;m++)
    	  {
    	    nn=pow(2,m);
    	    if(n==nn)break;
    	  }
	if(m>16)
	  {
        printf(" N is not a power of 2 ! \n");
	    return;
	  }
	    n2=n*2;
        es=-isign*atan(1.0)*8.0;
   for(k=1;k<m;k++)
     {
            n2=n2/2;
            n4=n2/4;
            e=es/n2;
            a=0.0;
            for(j=0;j<n4;j++)
               {
                a3=3*a;
                cc1=cos(a);
                ss1=sin(a);
                cc3=cos(a3);
                ss3=sin(a3);
                a=(j+1)*e;
                is=j;
                id=2*n2;
                 do
                  {
                    for(i0=is;i0<n;i0+=id)
                       {
                           i1=i0+n4;
                            i2=i1+n4;
                            i3=i2+n4;
                            r1=x[i0].real-x[i2].real;
                            s1=x[i0].imag-x[i2].imag;
                            r2=x[i1].real-x[i3].real;
                            s2=x[i1].imag-x[i3].imag;
                            x[i0].real+=x[i2].real;x[i0].imag+=x[i2].imag;
                            x[i1].real+=x[i3].real;x[i1].imag+=x[i3].imag;
                		    if(isign!=1)
                    		    {
                    		      s3=r1-s2;
                    		      r1+=s2;
                    		      s2=r2-s1;
                    		      r2+=s1;
                    		    }
                    		 else
                    		    {
                    		      s3=r1+s2;
                    		      r1=r1-s2;
                    		      s2=-r2-s1;
                    		      r2=-r2+s1;
                                 }
                    		x[i2].real=r1*cc1-s2*ss1;
                    		x[i2].imag=-s2*cc1-r1*ss1;
                    		x[i3].real=s3*cc3+r2*ss3;
                    		x[i3].imag=r2*cc3-s3*ss3;
                        }
                   is=2*id-n2+j;
                  id=4*id;
		  }while(is<n-1);
      }
  }
/*   ------------ special last stage -------------------------*/
        is=0;
        id=4;
      do
      {
        for(i0=is;i0<n;i0+=id)
           {i1=i0+1;
            xt.real=x[i0].real;
            xt.imag=x[i0].imag;
            x[i0].real=xt.real+x[i1].real;
            x[i0].imag=xt.imag+x[i1].imag;
            x[i1].real=xt.real-x[i1].real;
            x[i1].imag=xt.imag-x[i1].imag;
            }
        is=2*id-2;
        id=4*id;
       }while(is<n-1);
        j=1;
        n1=n-1;
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
            		if(k>=j)
                		 break;
            	    j-=k;
            	    k/=2;
        	    }while(1);
            j+=k;
        }
        if(isign==-1)
           return;
        for(i=0;i<n;i++)
    	   {
    	    x[i].real/=(float)n;
            x[i].imag/=(float)(n);
            }
 }

