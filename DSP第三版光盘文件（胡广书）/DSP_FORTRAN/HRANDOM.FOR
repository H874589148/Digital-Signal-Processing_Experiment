c----------------------------------------------------------------------
c  main program HRANDOM: to  test subroutine RANDOM(MEAVAR)
c  Please  link subroutine RANDOM(MEAVAR)
c----------------------------------------------------------------------
        dimension x(0:511)
        data p/2.0/,n/512/,itype/1/,iseed/12357/
        call random(x,n,iseed,itype,p,Ierror)
        write(*,*)'     Ierror=',Ierror
        if(ierror.ne.0)stop
        open(3,file='h1random.dat',status='NEW')
        do 1 i=0,n-1
1       write(3,*)i,x(i)
        close(3)
        stop
        end
