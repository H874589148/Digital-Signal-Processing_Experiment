        subroutine decint(x,h,y,nx,nh,ny,m,l,k0)
c----------------------------------------------------------------------
c Routine DECINT: Using eq. (9.4.33) to implement sampling rate
c   conversion by L/M.
c Note: First call routine DEFIR3 to design lowpass  filter, the cutoff
c       freq. Wp is given by equation (9.4.26) and the amplitude in
C       bandpss should be L,that is,Hd(w)=L,   so we can obtain the
c       impulse response  h(n), then call DECINT to complete needed
c       convesion.
c  Input parameters:
c   x(n):nx dimensioned real array,to be converted data is stored
c             in x(0) to x(n-1);
c   h(n):nh+1 dimensioned real array,impulse response is stored in
c             h(0) to h(nh) obtained by call DEFIR3 ;
c   M   : factor to decrease sampling freq. (for decimation)
c   L   : factor to increase sampling freq. (for interpolation)
c output parameters:
c   y(n):ny dimensioned real array, y(n),n=k0,...ny-1, have been
c            converted data. Generally,ny=nx*L/M
c                                      in Chapter 9
c----------------------------------------------------------------------
        dimension h(0:nh),x(0:nx-1),y(0:ny-1)
        k=(nh+1)/l
        if(l.ne.1)k0=k+1
        if(l.eq.1)k0=(nh+1)/m+1
        do 100 my=k0,ny-1
           y(my)=0
           do 100 mh=0,k-1
               ih=my*m/l
               ihl=ih*l
               ihh=my*m+mh*l-ihl
               ix=ih-mh
               a=0
               if(ix.lt.0) goto 90
               a=x(ix)
90             y(my)=y(my)+h(ihh)*a
100     continue
        return
        end
