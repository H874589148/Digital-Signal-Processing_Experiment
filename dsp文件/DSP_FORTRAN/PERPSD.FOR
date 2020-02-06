      subroutine perpsd(x,n,nshift,w,nsamp,iwidow,ts)
c-----------------------------------------------------------------------
c Routine PERPSD:To compute the averaged periodogram by Welch's method.
c   Input Parameters:
c     N      - Number of data samples;
c     NSHIFT - Number of samples shifted between every segment;
c     NSAMP  - Number of samples per segment (must be even);
c     X      - Array of complex samples, x(0) to x(n-1)
c     W      - Array of window function,
c     Iwidow - If =1,for rectangular window, not =1,for Hamming window.
c   Output Parameters:
c NSECTION   - Number of segments averaged;
c PSD        - Real array of power spectral density estimation values.
c                             in Chapter 11
c-----------------------------------------------------------------------
        complex x(0:n-1)
        real w(0:nsamp-1),psdr(0:4095),psdi(0:4095),work(0:4095)
        mfre=4096
        pi2=8.*atan(1.)
        tsv=0.0
        do 5 k=0,nsamp-1
           if(iwidow.eq.1) goto 5
           w(k)=0.538+0.462*cos(pi2*(-.5+float(k)/float(nsamp)))
           tsv=tsv+w(k)*w(k)
5       continue
        if(nshift.eq.0)nsection=n/nsamp
        if(nshift.ne.0)nsection=(n-nsamp)/(nsamp-nshift) + 1
        write(*,*)'   total segements=',nsection
        do 10 k=0,mfre-1
           work(k)=0.
10      continue
        do 50 k=1,nsection
           write(*,*)'   k=',k
           do 20 j=0,nsamp-1
              index=j+(k-1)*(nsamp-nshift)
              psdr(j)=real(x(index))
              psdi(j)=aimag(x(index))
              if(iwidow.eq.1) goto 20
              psdr(j)=psdr(j)*w(j)
              psdi(j)=psdi(j)*w(j)
20         continue
           do 30 j=nsamp,mfre-1
              psdr(j)=0.
              psdi(j)=0.
30         continue
        call relfft(psdr,psdi,mfre,-1)
           do 40 j=0,mfre-1
              psdr(j)=psdr(j)*psdr(j)+psdi(j)*psdi(j)
              psdr(j)=psdr(j)/float(nsamp)
              work(j)=work(j)+psdr(j)
40         continue
50      continue
c--------------------------------------------------------------------
        tsv=tsv*nsection*ts
        do 60 k=0,mfre-1
           psdr(k)=work(k)
           if(iwidow.eq.1) goto 60
           psdr(k)=psdr(k)/tsv
60      continue
        call psplot(psdr,psdi,mfre,ts)
        return
        end
