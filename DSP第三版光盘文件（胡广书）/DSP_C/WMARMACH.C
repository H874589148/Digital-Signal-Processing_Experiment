/*----------------------------------------------------------------------
   main program WARMACH :to test subroutine MARMACH
   To compute the coefficients of ARMA model and to estimate the PSD
   Need subroutine : MARMACH,MCORRE1,MCHOLSK,MARYUWA,MRELFFT,MPSPLOT
----------------------------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
#include "mcorre1.c"
#include "mrelfft.c"
#include "mcholsk.c"
#include "maryuwa.c"
#include "mpsplot.c"
#include "marmach.c"
void main()
{
        FILE *fp;
        complex x[128],a[20],b[20],ef[128];
        int k,ip,iq,m,n,i;
        float ts,ep;
        float *p_ep;
        p_ep=&ep;
        ip=10;iq=10;m=30;n=128;ep=1.0e-15;ts=1.0;
        if((fp=fopen("test.dat","r"))==NULL)
        {printf("cannot open file\n");
              exit(0);
              }
        for(k=0;k<n;k++)fscanf(fp,"%f,%f\n",&x[k].real,&x[k].imag);
        fclose(fp);
        marmach(x,ef,n,a,b,ip,iq,m,p_ep,ts);
        printf("a[i]=\n");
        for(i=0;i<=ip;i++) printf("%d,%f,%f\n",i,a[i].real,a[i].imag);
        printf("-------------------------------------------------\n");
        printf("b[i]=\n");
        for(i=0;i<=iq;i++) printf("%d,%f,%f\n",i,b[i].real,b[i].imag);
        printf("sig2=%f\n",ep);
        }


