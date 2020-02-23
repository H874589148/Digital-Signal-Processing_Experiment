#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
float randnu(long *iseed)
{
        float z;
        *iseed=2045*(*iseed)+1;
        *iseed=*iseed-(*iseed/1048576)*1048576;
        z=(float)((*iseed+1)/1048577.0);
        return(z);
 }
/*--------------------------------------------------------------------*/
void meavar(float u[],int *n,float *pum,float *puv)
{
        int i,k;
        *pum=0.0;
        for(k=0;k<*n;k++)
            *pum=*pum+u[k];
        *pum=*pum/(*n);
        *puv=0.0;
        for(i=0;i<*n;i++)
            *puv=*puv+pow((u[i]-*pum),2);
        *puv=*puv/(*n-1.);
        return;
        }
/*---------------------------------------------------------------------
  Routine mrandom : To generate the random number(pseudo-white noise).
  input Parameters:
  n    : the random data number requested; integer .
  iseed: the seed for pseudo-random data generation.it must be
         initialized by main program(suggested value is ISEED=12357),
         and the random number is cycled,the cycle length=1,048,576
  itype: random data distribution type, see below:
        itype=1: Uniform  distributed,from 0.0 to 1.0
        itype=2: Uniform  distributed,Mean=0.0, Variance(Power) p=1.0
        itype=3: Uniform  distributed,Mean=0.0, Variance(Power) p=p.
        itype=4: Gaussian distributed,Mean=0.0, Variance(Power) p=1.0
        itype=5: Gaussian distributed,Mean=0.0, Variance(Power) p=p.
  p    :variance(Power) of random, only used when itype=3 or itype=5.
  out parameters:
  u    :n dimensioned real array, data is stored in u(0) to u(n-1).
                                  in Chapter 1
---------------------------------------------------------------------*/
void mrandom(float u[],int *n,long *piseed,int itype,float p)
{
        int k,ns,ksection,ks,j;
        float a,v,umean,uvari;
        float *pum,*puv;
        pum=&umean;
        puv=&uvari;
        if(itype >6 || itype <1)
           return;
        for(k=0;k<*n;k++)
            u[k]=randnu(piseed);
        if(itype==2 || itype==3)
            {
                meavar(u,n,pum,puv);
            /* to obtain a zero mean and P-power random sequence u[k]).*/
                    a=12.;
                    if(itype==2)
                       p=sqrt(a);
                    if(itype==3)
                       p=sqrt(p*a);
                    for(k=0;k<*n;k++)
                       u[k]=(u[k]-umean)*p;

            }
        if(itype==4||itype==5)
            {
            /* to generate the Gaussian randow sequence u[k],k=0,1,2,...,ns-1*/
              ksection=12;
            ns=*n/ksection;
            ks=0;
            if (itype==4) p=1;
            p=sqrt(p);
            for(k=0;k<ns;k++)
               {v=0.0;
                for(j=0;j<ksection;j++)
                    v+=p*(u[j+ks]-.5);
                     u[k]=v;
                     ks=ks+ksection;
                     }
            *n=ns;
            }
        meavar(u,n,pum,puv);
        printf("   The mean     of u[n]=%f\n",umean);
        printf("   The variance of u[n]=%f\n",uvari);
        return;
        }

