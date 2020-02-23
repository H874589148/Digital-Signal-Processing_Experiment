#define abs_error 1.e-10

#ifndef _MSP_H_
#define _MSP_H_

typedef struct {float real,imag;} complex;
/*-------------------------------------------------------------------*/
float mabs(complex a)
{
 float m;
 m=a.real*a.real+a.imag*a.imag;
 m=sqrt(m);
 return(m);
 }
/*-------------------------------------------------------------------*/
float msign(float a,float b)
{
 float z;
 if(b>=0) z=sqrt(pow(a,2));
 else z=-sqrt(pow(a,2));
 return(z);
 }
/*-------------------------------------------------------------------*/
complex cexp(complex a)
{
 complex z;
 z.real=exp(a.real)*cos(a.imag);
 z.imag=exp(a.real)*sin(a.imag);
 return(z);
 }
/*-------------------------------------------------------------------*/
void maftodf(float d[],float c[],int ln,int iband,float fln,float fhn,
                float b[],float a[],int *ierror);
void mampres(complex h[],float amp[],int n,float fs,int iamp,char filename[]);
void mar1psd(complex a[],int ip,int mfre,float *ep,float ts);
void marburg(complex x[],complex a[],complex ef[],complex eb[],
             int n,int ip,float *ep,int *ierror);
void marmach(complex x[],complex ef[],int n,complex a[],
             complex b[],int ip,int iq,int m,float *ep,float ts);
void maryuwa(complex x[],complex a[],complex r[],int n,int ip,
             float *ep, int *ierror);
void mbiline(float d[],float c[],int ln,float b[],float a[],int *ierror);
void mbutwcf(int l,int k,int ln,float d[],float c[],int *ierror);
void mchebsh(int l,int k,int ln,float d[],float c[],float phi2,
             int *ierror);
void mcholsk(complex a[],complex b[],int n,float eps,int *iflag);
void mcmpdft(complex x[],complex y[],int n,int isign);
void mcmpfft(complex x[],int n,int isign);
void mconvo1(float x[],float h[],float y[],int n,int m,int L);
void mconvo2(complex x[],complex h[],complex y[],int n1,int n2,int n);
void mcorpsd(complex x[],complex r[],int n,int lag,int iwindow,float t);
void mcorre1(complex x[],complex y[],complex r[],int n,int lag);
void mcorre2(complex x[],complex y[],int m,int n,int icorre);
void mcztfft(complex x[],int n,int m,int maxnm,float dltomg,
             float omg0,float fs,int *ierror);
void mdecint(float x[],float h[],float y[],int nh,int ny,int m,
             int l,int *k);
void mdefir1(int l,int iband,float fl,float fh,float fs,int iwindow,
             float b[],float w[],int *ierror);
void mdefir2(int l,int iband,float fl,float fh,complex b[],
             float trans,float fs,int *ierror);
void mdefir3(int nfilt,int nbands,float edge[],float fx[],
             float wtx[],float h[]);
void mdesiir(float *f1,float *f2,float *f3,float *f4,float fs,
             float alpha1,float alpha2,int iband,int itype);
void mfirres(float b[],int lb,int n,complex h[]);
void mfitout(float b[],float a[],int lb,int la,float x[],
             int n,float y[]);
void miirres(float a[],float b[],int lb,int la,complex h[],int n);
void mlattic(float b[],float a[],int l,float k[],
             float c[],int itype ,int *ierror);
void mmayuwa(complex x[],int n,complex a[],int ip,complex b[],int iq,
             complex r[],float *ep, float ts,int *ierror);
void mmvseps(complex x[],complex ef[],complex eb[],int n,complex a[],
             int ip,int *ierror,float ts);
void morderb(float *f1,float *f2,float *f3,float *f4,float fs,float alpha1,
             float alpha2,int *l,int iband,int itype,int *ierror);
void mperpsd(complex x[],int n,int nshift,int nsamp,int iwidow,float ts);
void mphares(complex h[],float phase[],int n,float fs,char filename[]);
void mprgfft(complex x[],int n,int l,int lf,int k1,int isign);
void mpsplot(float psdr[],float psdi[],int mfre,float ts);
             float randnu(long *iseed);
void meavar(float u[],int *n,float *pum,float *puv);
void mrandom(float u[],int *n,long *piseed,int ITYPE,float p);
void mrelfft(float xr[],float xi[],int n,int isign);
             float d(int k,int n,int m);
             float gee(int k,int n);
void mremez1();
void msplfft(complex x[],int n,int isign);
void munwrap(float phase[],int n);
void mwindow(float w[],int n,int iwindow,int *ierror);
int  mspbfct(int i1,int i2);

/*-------------------------------------------------------------------*/
#endif

