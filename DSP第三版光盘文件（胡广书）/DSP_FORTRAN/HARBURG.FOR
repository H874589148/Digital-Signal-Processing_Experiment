c----------------------------------------------------------------------
c   main program harburg : to test subroutine ARBURG
c   To compute the AR model coefficients by Burg algorithm ,IP=10
c   Please  link subroutine ARBURG,AR1PSD RELFFT,PSPLOT
c----------------------------------------------------------------------
        complex x(0:127),a(0:10),ef(0:127),eb(0:127)
        data n/128/,ip/10/,mfre/4096/,ts/1./
        open(3,file='test.dat',status='old')
        do 20 k=0,n-1
           read(3,*)x(k)
20      continue
        close(3)
        call arburg(x,a,ef,eb,n,ip,ep,ierror)
        if(ierror.eq.0) goto 30
        write(*,*)'   stop at rotine aryuwa,    ierror=',ierror
        stop
30      write(*,*)'   white noise variance=',ep
        write(*,*)'              k               a(k)'
        do 40 k=0,ip-1
40      write(*,41)k,a(k)
41      format('      ',i10,2f14.6)
        call ar1psd(a,ip,mfre,ep,ts)
        stop
        end
