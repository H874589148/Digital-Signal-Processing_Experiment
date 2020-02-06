/*----------------------------------------------------------------------
   main program WMVSEPS :to test subroutine MMVSEPS
   To compute the PSD of test.dat by MVSE method. The order ip=13
   Need subroutine : MMVSEPS,MARBURG,MRELFFT,MPSPLOT
----------------------------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
#include "mrelfft.c"
#include "mpsplot.c"
#include "marburg.c"
#include "mmvseps.c"
void main()
{
        FILE *fp;
        complex x[128],ef[128],eb[128],a[32];
        int n,ip,k,ierror;
        int *ierr;
        float ts;
        ierr=&ierror;
        n=128;ip=13;
        ts=1.;
        if((fp=fopen("test.dat","r"))==NULL)
        {printf("cannot open file\n");
              exit(0);
              }
        for(k=0;k<n;k++)
            fscanf(fp,"%f,%f\n",&x[k].real,&x[k].imag);
            fclose(fp);
        mmvseps(x,ef,eb,n,a,ip,ierr,ts);
        printf("     ierror=%d\n",ierror);
        printf("              k               a(k)  \n");
        for(k=0;k<=ip;k++)
        printf("    %d,    %f,%f\n",k,a[k].real,a[k].imag);
        }


