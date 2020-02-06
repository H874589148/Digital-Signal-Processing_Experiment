      subroutine ar1psd(a,ip,mfre,ep,ts)
c-----------------------------------------------------------------------
c   Routine AR1PSD: To compute the power spectum by AR-model parameters.
c   Input parameters:
c          IP   : AR model order (integer)
c          EP   : White noise variance of model input (real)
c          Ts   : Sampling interval in seconds (real)
c          A    : Complex array of AR  parameters, A(0) to A(IP)
c   Output parameters:
c          PSDR : Real array of power spectral density values
c          PSDI : Real work array
c                                       in chapter 12
c-----------------------------------------------------------------------
        complex a(0:ip)
        dimension psdr(0:4095),psdi(0:4095)
        do 10 k=0,ip
           psdr(k)=real(a(k))
           psdi(k)=aimag(a(k))
10      continue
        do 20 k=ip+1,mfre-1
           psdr(k)=0.
           psdi(k)=0.
20      continue
        call relfft(psdr,psdi,mfre,-1)
        do 30 k=0,mfre-1
           p=psdr(k)**2+psdi(k)**2
           psdr(k)=ep*ts/p
30      continue
        call psplot(psdr,psdi,mfre,ts)
        return
        end
