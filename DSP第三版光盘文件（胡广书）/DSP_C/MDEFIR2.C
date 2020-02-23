#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mdefir2(int l,int iband,float fl,float fh,complex b[],
float trans,float fs,int *ierror)
{
/*---------------------------------------------------------------------
  Fl:low cut-off frequency. Fh:high cut-off(For BP,BS). fl,fh,fs in Hz
          |---        |   ---      |   ---           |--      --
          |   |       |  |         |  |   |          |  |    |
          |   |       |  |         |  |   |          |  |    |
        --|------    -|--------   -|-----------    --|--------------
          0   fl      0  fl       0   fl  fh       0    fl   fh

   Digital filter coefficients are returned in b(l)
                h(z)=b(0)+b(1)z^(-1)+ ... +b(l-1)z^(-l+1)
  Input parameters:
   l    : the length of FIR filter. l<201 and l must be the odd.
   iband:  iband=1 low  pass FIR filter.
           iband=2 high pass FIR filter.
           iband=3 band pass FIR filter.
           iband=4 band stop FIR filter.
   trans:   0<= trans <1.0 , it is the transition point.
  Output parameters:
   b: l dimensioned real array.the result is in b(0) to b(l-1).

                                       in Chapter 8
---------------------------------------------------------------------*/
        complex h[201];
        complex z;
        int i,lim,nlow,nhigh;
        float pi,fln,fhn,dly,band,s;
        pi=4.*atan(1.);
        fln=fl/fs;
        fhn=fh/fs;
        for(i=0;i<l;i++)
           {h[i].real=0.;
            h[i].imag=0.0;
            }
        *ierror=0;
        dly=(float)l/2.;
        lim=l/2;
        if(dly==(float)lim)
           *ierror=1;
        if(l>=201)
           *ierror=2;
        if(iband==4)
            band=(fhn-fln)*l;
        if(iband==4&&band<4.)
        {
            printf("  Please increse the length L for Band-Stop Filter\n");
            *ierror=3;
        }
        if(iband<1||iband>4)
           *ierror=4;
        if(fln<=0.||fln>0.5)
           *ierror=5;
        if(iband>=3&&fln>=fhn)
           *ierror=6;
        if(trans<0.0&&trans>=1.)
           *ierror=7;
        if(*ierror!=0)
           return;
        s=-(l-1)*pi/l;
        switch(iband)
              {case 1:
                  {
                    nlow=1;
                    nhigh=fln*l-1;
                    h[0].real=1.0;h[0].imag=0.0;
                    for(i=nlow;i<=nhigh;i++)
                       {
                        z.real=0.0;
                        z.imag=s*i;
                        z=cexp(z);
                        h[i].real=z.real;
                        h[i].imag=z.imag;
                        h[l-i].real=h[i].real;
                        h[l-i].imag=-h[i].imag;
                        }
                    z.real=0.0;
                    z.imag=s*(nhigh+1);
                    z=cexp(z);
                    h[nhigh+1].real=trans*z.real;
                    h[nhigh+1].imag=trans*z.imag;
                    h[l-nhigh-1].real=h[nhigh+1].real;
		    h[l-nhigh-1].imag=-h[nhigh+1].imag;
		    break;
                  }
               case 2:
                       {
                       h[0].real=0.0;
                        h[0].imag=0.0;
                        nlow=fln*l;
                        nhigh=lim;
                        for(i=nlow;i<=nhigh;i++)
                           {z.real=0.0;
                            z.imag=s*i;
                            z=cexp(z);
                            h[i].real=z.real;
                            h[i].imag=z.imag;
                            h[l-i].real=h[i].real;
                            h[l-i].imag=-h[i].imag;
                            }
                        z.real=0.0;
                        z.imag=s*(nlow-1);
                        z=cexp(z);
                        h[nlow-1].real=trans*z.real;
                        h[nlow-1].imag=trans*z.imag;
                        h[l-nlow+1].real=h[nlow-1].real;
			h[l-nlow+1].imag=-h[nlow-1].imag;
			break;
                       }
               case 3:
                       {
                        nlow=fln*l;
                        nhigh=fhn*l;
                        h[0].real=0.0;h[0].imag=0.0;
                        for(i=nlow;i<=nhigh;i++)
                           {z.real=0.0;z.imag=s*i;
                            z=cexp(z);
                            h[i].real=z.real;
                            h[i].imag=z.imag;
                            h[l-i].real=h[i].real;
                            h[l-i].imag=-h[i].imag;
                            }
                        z.real=0.0;
                        z.imag=s*(nhigh+1);
                        z=cexp(z);
                        h[nhigh+1].real=trans*z.real;
                        h[nhigh+1].imag=trans*z.imag;
                        h[l-nhigh-1].real=h[nhigh+1].real;
                        h[l-nhigh-1].imag=-h[nhigh+1].imag;
                        z.real=0.0;
                        z.imag=s*(nlow-1);
                        z=cexp(z);
                        h[nlow-1].real=trans*z.real;
                        h[nlow-1].imag=trans*z.imag;
                        h[l-nlow+1].real=h[nlow-1].real;
			h[l-nlow+1].imag=-h[nlow-1].imag;
			break;
                       }
               case 4:
                  {
                    nlow=1;
                    nhigh=fln*l-1;
                    h[0].real=1.0;h[0].imag=0.0;
                    for(i=nlow;i<=nhigh;i++)
                       {z.real=0.0;
                        z.imag=s*i;
                        z=cexp(z);
                        h[i].real=z.real;
                        h[i].imag=z.imag;
                        h[l-i].real=h[i].real;
                        h[l-i].imag=-h[i].imag;
                        }
                    z.real=0.0;
                    z.imag=s*(nhigh+1);
                    z=cexp(z);
                    h[nhigh+1].real=trans*z.real;
                    h[nhigh+1].imag=trans*z.imag;
                    h[l-nhigh-1].real=h[nhigh+1].real;
                    h[l-nhigh-1].imag=-h[nhigh+1].imag;
                    nlow=fhn*l;
                     nhigh=lim;
                    for(i=nlow;i<=nhigh;i++)
                       {z.real=0.0;
                        z.imag=s*i;
                        z=cexp(z);
                        h[i].real=z.real;
                        h[i].imag=z.imag;
                        h[l-i].real=h[i].real;
                        h[l-i].imag=-h[i].imag;
                        }
                    z.real=0.0;
                    z.imag=s*(nlow-1);
                    z=cexp(z);
                    h[nlow-1].real=trans*z.real;
                    h[nlow-1].imag=trans*z.imag;
                    h[l-nlow+1].real=h[nlow-1].real;
		    h[l-nlow+1].imag=-h[nlow-1].imag;
		    break;
                }
       }
  mcmpdft(h,b,l,1);
 }

