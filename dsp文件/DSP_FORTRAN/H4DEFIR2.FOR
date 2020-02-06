C----------------------------------------------------------------------
c  main program H4DEFIR2: to test subroutine DEFIR2
C  To design FIR band-stop filter by frequency sampling method
c  Please link subroutine DEFIR2,FIRRES,AMPRES,PHARES,UNWRAP
C----------------------------------------------------------------------
        dimension b(0:40),amp(0:255),phase(0:255)
        complex h(0:255),bcmplx(0:40)
        data l/40/,n/256/,iband/4/,iamp/0/
        data fs/1.0/,fl/0.2/,fh/0.3/,trans/0.5/
        call defir2(l,iband,fl,fh,bcmplx,trans,fs,ierror)
        write(*,*)'    ierror=',ierror
        if(ierror.ne.0)stop
        do 10 i=0,l
           b(i)=real(bcmplx(i))
           write(*,*)i,b(i)
10      continue
        open(3,file='h4hdfir2.dat',status='new')
        do 20 k=0,l
           write(3,*)k,b(k)
20      CONTINUE
        close(3)
        call firres(b,l,n,h)
        call ampres(h,amp,n,fs,iamp)
        call phares(h,phase,n,fs)
        stop
        end
