        subroutine corpsd(x,r,n,lag,iwindow,t)
c-----------------------------------------------------------------------
c   Routine CORPSD: To compute the power specturm by auto-correlation
c                     method (Blackman-Tukey method).
c   Input Parameters:
c     X   : Array of complex data samples form 0 to n-1
c     N   : Number of data samples
c     MFRE: Data number of power spectrum
c     LAG : the highest lag index to compute
c   Output Parameters:
c     r(m):Array of complex correlation from 0 to Lag-1
c                                      in Chapter 11
c-----------------------------------------------------------------------
        complex x(0:n-1),r(0:lag-1)
        dimension psdr(0:4095),psdi(0:4095)
        data mfre/4096/
        call corre1(x,x,r,n,lag,ierror)
        write(*,*)'     ierror=',ierror
        pi2=8.*atan(1.)
        s=pi2/float(2*lag)
        do 20 k=0,lag-1
           psdr(k)=real(r(k))
           psdi(k)=aimag(r(k))
           if(iwindow.eq.1) goto 20
           w=0.54+0.46*cos(s*k)
           psdr(k)=psdr(k)*w
           psdi(k)=psdi(k)*w
20      continue
        do 30 k=1,lag-1
           psdr(mfre-k)=psdr(k)
           psdi(mfre-k)=-psdi(k)
30      continue
        do 40 k=lag,mfre-lag
           psdr(k)=0.
           psdi(k)=0.
40      continue
        call relfft(psdr,psdi,mfre,-1)
        do 50 k=0,mfre-1
           psdr(k)=psdr(k)*psdr(k)+psdi(k)*psdi(k)
50      continue
        call psplot(psdr,psdi,mfre,t)
        return
        end
