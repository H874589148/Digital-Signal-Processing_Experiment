    function [f,t]=cut_frame(signal,window,increment)
            L = length(signal);
            W = length(window);
            Len = W;
            Nf = fix((L-W)/increment)+1;
            f = zeros(Nf,Len);
            Ind=(repmat((0:(Nf-1))'*increment,1,Len)+repmat(1:Len,Nf,1))';
            windowMatrix=repmat(window,1,Nf);
            f=signal(Ind).*windowMatrix;
            if nargout > 1
                t = (1+W)/2+ increment*(0:(Nf-1)).';
            end
            f=f';
    end