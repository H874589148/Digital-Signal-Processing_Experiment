C----------------------------------------------------------------------
c  main program H1DEFIR3: to test subroutine DEFIR3
C  To design FIR low-pass filter by Chebyshev
C                                optimum approximation method.
c  Please link subroutine DEFIR3,REMEZ1,FIRRES,AMPRES,PHARES,UNWRAP
C----------------------------------------------------------------------
        complex h(0:499)
        dimension b(0:32),edge(1:4),fx(1:2),wtx(1:2)
        dimension amp(0:499),phase(0:499)
        data nfilt/32/,nbands/2/,npsd/500/,iamp/1/,fs/1.0/
        data edge(1)/0./,edge(2)/0.3/, edge(3)/0.35/,edge(4)/.5/
        data fx(1)/1.0/,fx(2)/0.0/
        data wtx(1)/1./,wtx(2)/10./
        call defir3(nfilt,nbands,edge,fx,wtx,b)
        open(3,file='h1hdfir3.dat',status='new')
        do 20 k=0,nfilt
           write(3,*)k,b(k)
20      CONTINUE
        close(3)
        call firres(b,nfilt,npsd,h)
        call ampres(h,amp,npsd,fs,iamp)
        call phares(h,phase,npsd,fs)
        stop
        end
