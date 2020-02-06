C----------------------------------------------------------------------
c  main program H3DEFIR3: to test subroutine DEFIR3
C  To design FIR multi-pass band filter by Chebyshev
C                                optimum approximation method.
c  Please link subroutine DEFIR3,REMEZ1,FIRRES,AMPRES,PHARES,UNWRAP
C----------------------------------------------------------------------
        dimension b(0:64),edge(1:14),fx(1:7),wtx(1:7)
        dimension amp(0:499),phase(0:499)
        complex h(0:499)
        data nfilt/64/,nbands/7/,npsd/500/,iamp/1/,fs/1.0/
        data edge(1)/0./,edge(2)/0.07/, edge(3)/0.09/,edge(4)/.11/
        data edge(5)/0.13/,edge(6)/0.17/, edge(7)/0.19/,edge(8)/.21/
        data edge(9)/0.23/,edge(10)/0.27/, edge(11)/0.29/,edge(12)/.31/
        data edge(13)/0.33/,edge(14)/0.5/
        data fx(1)/0.0/,fx(2)/1.0/,fx(3)/0.0/,fx(4)/1.0/
        data fx(5)/0.0/,fx(6)/1.0/,fx(7)/0.0/
        data wtx(1)/8./,wtx(2)/1./,wtx(3)/8./,wtx(4)/1./
        data wtx(5)/8./,wtx(6)/1./,wtx(7)/8./
        call defir3(nfilt,nbands,edge,fx,wtx,b)
        open(3,file='h3hdfir3.dat',status='new')
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