  #include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
void mdesiir(float *f1,float *f2,float *f3,float *f4,float fs,
                    float alpha1,float alpha2,int iband,int itype)
{
/*----------------------------------------------------------------------
 Routine mdesiir:to design LP,HP,BP,BS digital Butterworth and Chebyshev
 filter. All array has been specified internally,so user only need to
 input f1,f2,f3,f4,fs(in hz), alpha1,alpha2(in db) and iband (to specify
 the type of to design). This program output hk(z)=bk(z)/ak(z),k=1,2,...,
   ksection and the freq. response h(exp(jwk)),k=0,1,...,n-1
   itype=0     butterworth IIR filter.
        =1     chebyshev   IIR filter.
 Input parameters:
   f1,f2,f3,f4: the edge frequency desired, see following figure(in Hz):
  alpha1 |---\       |     /---    |     /---\         |--\         /--
         |    \      |    /   |    |    /     \        |   \       /
         |     \     |   /    |    |   /       \       |    \     /
 alpha2--|------\-  -|--/-----|-  -|--/---------\---  -|-----\---/------
         0  f1  f2   0  f1    f2   0  f1 f2  f3 f4     0  f1 f2  f3 f4
      f3=*,f4=*        f3=*,f4=*
     iband=1 LP      iband=2 HP        iband=3 BP          iband=4 BS
   fs: sampling frequnecy in Hz.
   alpha1: attenuate coef of passing band, in dB form.
   alpha2: attenuate coef of stopping band, in dB form.
   iband:  iband=1 low  pass IIR filter.
           iband=2 high pass IIR filter.
           iband=3 band pass IIR filter.
           iband=4 band stop IIR filter.
   itype:  itype=0 Butterworth IIR filter.
           itype=1 Chebyshev IIR filter.
  Output parameters:
   Note. the screen output will demostrate you IIR system function
       in cascade form.
                                       in chapter 7
----------------------------------------------------------------------*/
        FILE *fp;
        char filename[30];
        float  work[20][20],b[20],a[20],d[10],c[10];
        float  amp[300],phase[300],freq[300];
        float a1,eps,phi2,fln,flh,s,hr;
        complex h[300];
        int n,ln,i,l,ksection,k1,k;
        int ierror=0;
        int *ierr,*ml;
        ierr=&ierror;
        ml=&l;
        fln=0.;flh=0.;
        n=256;ln=3;
        for(i=ln;i<20;i++)
           {
            a[i]=0.0;
            b[i]=0.0;
            }
        for(i=0;i<n;i++)
           {
            phase[i]=0.0;
            amp[i]=1.;
            }
        printf("iband=%d,itype=%d\n",iband,itype);
        morderb(f1,f2,f3,f4,fs,alpha1,alpha2,ml,iband,itype,ierr);
        if(ierror!=0)
            {
                printf(" stop at routine ORDERB, ierror=%d\n",ierror);
                return;
            }
        if(itype!=0)
            {
                a1=alpha1/10.0;
                eps=sqrt(pow(10.0,a1)-1.0);
                printf("eps=%d\n",eps);
                phi2=log(1.0/eps+sqrt(1.0/pow(eps,2)+1))/l;
            }
        fln=*f1/fs;
        flh=*f2/fs;
        if(l<=1)
            ksection=1;
        else
           ksection=(l%2==0)?(l/2):((l+1)/2);
        if(iband==3||iband==4)ln=5;
        for(k1=1;k1<=ksection;k1++)
           {
            if(itype==0) mbutwcf(l,k1,ln,d,c,ierr);
            if(itype==1) mchebsh(l,k1,ln,d,c,phi2,ierr);
            if(ierror!=0)
                {
                    printf(" stop at routine BUTWCF,  ierror=%d\n",ierror);
                    return;
                }
            printf("--------------- for ksection=%d------------\n",k1);
            printf("    Analog low-pass filter hk(s)=dk(s)/ck(s)\n");
            for(k=0;k<ln;k++)
               printf("      d(%d)=%f,      c(%d)=%f\n",k,d[k],k,c[k]);
            maftodf(d,c,ln,iband,fln,flh,b,a,ierr);
            if(ierror!=0)
                {
                    printf(" stop at routine AFTODF, ierror=%d\n",ierror);
                    return;
                }
            a[0]=1.;
            printf("    Digital low-pass filter hk(z)=bk(z)/ak(z)\n");
            for(k=0;k<ln;k++)
               printf("      b(%d)=%f,      a(%d)=%f\n",k,b[k],k,a[k]);
            miirres(a,b,ln-1,ln-1,h,n);
            s=.5*fs/(float)n;
            for(k=0;k<n;k++)
               {freq[k]=s*k;
               amp[k]*=mabs(h[k]);
               hr=h[k].real;
               if(hr==0.0) hr=.0001;
               phase[k]+=atan2(h[k].imag,hr);
               }
            }
        munwrap(phase,n);
        printf("Please input amplitude filename:\n");
        scanf("%s",filename);
        if((fp=fopen(filename,"w"))==NULL)
        {printf("cannot open file\n");
        exit(0);
          }
        for(i=0;i<n;i++)
           {if(amp[i]<=0.0)amp[i]=0.0001;
            if(itype==1)amp[i]/=eps*pow(2.0,l-1);
            amp[i]=20.*log10(amp[i]);
            fprintf(fp,"%f,%f\n",freq[i],amp[i]);
             }
        fclose(fp);
        printf("Please input phase filename:\n");
        scanf("%s",filename);
        if((fp=fopen(filename,"w"))==NULL)
        {printf("cannot open file\n");
         exit(0);
          }
         for(i=0;i<n;i++)
                 fprintf(fp,"%f,%f\n",freq[i],phase[i]);
         fclose(fp);
         return;
  }

