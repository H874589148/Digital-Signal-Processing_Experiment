function X = wienerfilter(YY,silentFrameNo,noise_est)
    a = 0.95;
    Gain = ones(size(noise_est));
    X=zeros(size(YY));
    last_post_SNR=Gain;   
    frame_Num = size(YY,2);

     for i=(silentFrameNo+1):frame_Num
        current_post_SNR=(YY(:,i).^2)./noise_est;   % posterior SNR  = Y^2/Noise^2;
        prior_SNR=a*(Gain.^2).*last_post_SNR+(1-a).*max(current_post_SNR-1,0);    % prior SNR =X^2 / Noise^2 = (Gain*Y)^2/Noise^2 = Gain^2 * posterior SNR
        last_post_SNR = current_post_SNR;                 % record current posterior SNR;
        Gain=(prior_SNR./(prior_SNR+1));                  % gain = prior SNR/(prior SNR+1) = X^2 / (X^2 + Noise^2)
        X(:,i)=Gain.*YY(:,i); 
     end
 
end