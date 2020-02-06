#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "msp.h"
float ad[66],x[66],y[66],grid[1045],des[1045],wt[1045],alpha[66];
int iext[66];
float pi2,dev;
int nfcns,ngrid,niter;
void mdefir3(int nfilt,int nbands,float edge[],float fx[],
float wtx[],float h[])
{
/*---------------------------------------------------------------------
 mdefir3: To design FIR filter by Weighted Chebyshev Approximation.
  Input parameters:
 nfilt  : the length of FIR filter,in this program nfilt<128;
 nbands :Number of bands,in this program nbands<=10;
 fx     :Desired function array for each band,from fx(1) to fx(nbands);
 wtx    :Weight function array in each band,from wtx(1) to wtx(nbands);
 edge   :Bandedge array,lower and upper freq. for each band,from
          edge(1) to edge(2*nbands);
  Output parameters:
       h: nfilt dimensioned real array,the impulse response.
                                       in chapter 8
---------------------------------------------------------------------*/
        float pi,delf,fup,temp,change,a,xt;
        int j,nfmax,lgrid,nodd,l,lband,nm1,nz,nzmj,nf2j;
        pi2=8.*atan(1.);
        pi=pi2/2.;
        nfmax=128;
        lgrid=16;
        if(nfilt==0)
           return;
	if(nfilt>nfmax || nfilt<3)
		return;
       if(nbands<=0)
           nbands=1;
        nodd=nfilt/2;
        nodd=nfilt-2*nodd;
        nfcns=nfilt/2;
        if(nodd==1)
           nfcns++;
        grid[1]=edge[1];
        delf=lgrid*nfcns;
        delf=0.5/delf;
        if(edge[1]<delf)
           grid[1]=delf;
        j=1;
        l=1;
        lband=1;
	do
	{
	fup=edge[l+1];
	do
	{
	temp=grid[j];
        des[j]=fx[lband];
        wt[j]=wtx[lband];
        j++;
        grid[j]=temp+delf;
	if(grid[j]>fup)
		break;
	}while(1);
	grid[j-1]=fup;
        des[j-1]=fx[lband];
        wt[j-1]=wtx[lband];
        lband++;
        l+=2;
	if(lband>nbands)
		break;
	grid[j]=edge[l];
	}while(1);
	ngrid=j-1;
	if(nodd==0)
	  if(grid[ngrid]>(.5-delf))
	      ngrid-=1;
/*-------------------------------------------------------------------*/
	if(nodd!=1)
	 for(j=1;j<=ngrid;j++)
	   {
	    change=cos(pi*grid[j]);
            des[j]/=change;
            wt[j]*=change;
            }
	temp=(float)(ngrid-1)/(float)(nfcns);
        for(j=1;j<=nfcns;j++)
	   {
	    xt=j-1;
            iext[j]=xt*temp+1.;
            }
        iext[nfcns+1]=ngrid;
        nm1=nfcns-1;
        nz=nfcns+1;
/*-------------------------------------------------------------------*/
        mremez1();
	if(nodd!=0)
	{
	for(j=0;j<nm1;j++)
           {nzmj=nfcns-j;
            h[j]=.5*alpha[nzmj];
            h[nfilt-j-1]=h[j];
            }
	h[nm1]=alpha[1];
	}
	else
	{
	h[0]=.25*alpha[nfcns];
        h[nfilt-1]=h[0];
        for(j=1;j<nm1;j++)
           {nzmj=nfcns-j;
            nf2j=nz-j;
            h[j]=.25*(alpha[nzmj]+alpha[nf2j]);
            h[nfilt-j-1]=h[j];
            }
        h[nm1]=.5*alpha[1]+.25*alpha[2];
	h[nfcns]=h[nm1];
	}
	h[nfilt]=0.0;
        printf("\n");
        printf("          Deviation   Deviation(db)\n");
        for(j=1;j<=nbands;j++)
           {a=dev/wtx[j];
            printf(" Band%d,   %f,    %f\n",j,a,20.*log10(a+fx[j]));
            }
        return;
        }

