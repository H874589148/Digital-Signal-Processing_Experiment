/*---------------------------------------------------------------------
 main program WMAYUWA :to test subroutine MMAYUWA
 To compute the coefficients of the MA model.
 Need subroutine :MARYUWA,MCORRE1,MRELFFT,MPSPLOT
---------------------------------------------------------------------*/
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "msp.h"
#include "mcorre1.c"
#include "mrelfft.c"
#include "mpsplot.c"
#include "maryuwa.c"
#include "mmayuwa.c"
void main()
{
        FILE *fp;
        complex x[128],b[32],a[32],r[32];
        int ip,iq,n,i,k,ierror;
        int *ierr;
        float t,ep;
        float *p_ep;
        ierr=&ierror;
        p_ep=&ep;
        ip=25;iq=10;t=1.0;n=128;ep=0.;ierror=0;
        if((fp=fopen("test.dat","r"))==NULL)
           {printf("cannot open file\n");
            exit(0);
            }
        for(i=0;i<n;i++)
            fscanf(fp,"%f,%f\n",&x[i].real,&x[i].imag);
            fclose(fp);
        mmayuwa(x,n,a,ip,b,iq,r,p_ep,t,ierr);
        printf("   white noise variance=%f\n",ep);
        printf("            k        b[k]\n");
        for(k=0;k<=iq;k++)
             printf("%d,%f,%f\n",k,b[k].real,b[k].imag);
        printf("            k        a[k]\n");
        for(k=0;k<=ip;k++)
            printf("%d,%f,%f\n",k,a[k].real,a[k].imag);
            }

