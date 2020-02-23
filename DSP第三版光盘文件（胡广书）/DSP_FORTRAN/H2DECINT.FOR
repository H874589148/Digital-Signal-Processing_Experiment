c----------------------------------------------------------------------
c   Main program H2DECINT : to test subroutine DECINT
C   To implement sampling rate conversion by factor M=2
c   Please link subroutine DECINT,DEFIR3,REMEZ1,FIRRES,AMPRES,
c                                               PHARES,UNWRAP
c----------------------------------------------------------------------
        complex h(0:499)
        dimension b(0:32),edge(1:4),fx(1:2),wtx(1:2)
        dimension amp(0:499),phase(0:999)
        data nfilt/32/,nbands/2/,npsd/500/,iamp/1/,fs/1.0/
        data edge(1)/0./,edge(2)/0.25/, edge(3)/0.3/,edge(4)/.5/
        data fx(1)/1.0/,fx(2)/0.0/
        data wtx(1)/2./,wtx(2)/1./
        data nx/500/,m/2/,l/1/,nml/1000/
        call defir3(nfilt,nbands,edge,fx,wtx,b)
        call firres(b,nfilt,npsd,h)
        call ampres(h,amp,npsd,fs,iamp)
        call phares(h,phase,npsd,fs)
c
        pi2=8.*atan(1.)
        fs=160.
        f=10.
        s=pi2*f/fs
        do 10 i=0,nx-1
           amp(i)=sin(s*i)
10      continue
        ny=nx*l/m
        if(ny.gt.nml)ny=nml
        call decint(amp,B,phase,nx,nfilt,ny,m,l,k)
        open(3,file='h2decint.dat',status='new')
           DO 43 I=k,ny-1
              write(3,*)i,phase(i)
43         continue
        close(3)
        stop
        end
