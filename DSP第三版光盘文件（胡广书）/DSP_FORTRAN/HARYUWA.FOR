c----------------------------------------------------------------------
c   main program HARYUWA :to test subroutine ARYUWA
c To compute AR model coefficients by solving Yule-Walker, ip=10
c Please link subroutine ARYUWA,CORRE1,AR1PSD RELFFT,PSPLOT
c----------------------------------------------------------------------
        complex x(0:127),r(0:10),a(0:10)
        data n/128/,ip/10/,mfre/4096/,t/1./
        open(3,file='test.dat',status='old')
        do 20 k=0,n-1
           read(3,*)x(k)
20      continue
        close(3)
        call aryuwa(x,a,r,n,ip,ep,ierror)
        if(ierror.eq.0) goto 30
        write(*,*)'   stop at rotine aryuwa,    ierror=',ierror
        stop
30      write(*,*)'   white noise variance=',ep
        write(*,*)'              k           a(k)'
        do 40 k=0,ip
40      write(*,41)k,a(k)
41      format('      ',i10,2f14.6)
        call ar1psd(a,ip,mfre,ep,t)
        stop
        end
