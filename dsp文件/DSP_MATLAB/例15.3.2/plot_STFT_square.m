function y = plot_STFT_square(s_input,fs);
    window_length = 0.01;                    % 设定窗宽；默认0.02s；
    wnd_length = fix(window_length*fs);
    wnd = hamming(wnd_length);
    inc = fix(wnd_length / 2); 
    [f,t] = cut_frame(s_input,wnd,inc);             % 对语音信号分帧；
    f = f';
    [m,n]=size(f);
%     f = f(1:(fix(m/2)+1),:)
    ff =fft(f);
%     ff = abs(f(1:(fix(m/2)+1),:));
    ff = abs(ff).^2;
    ff = ff(1:(fix(m/2)+1),:);

    x=ff;
    [m2,n2]=size(x);

    y=zeros(m2,n2);
    db=60;
    plim=max(x(:))*[0.1^(0.05*db) 1];
    y=10*log10(min(max(x,plim(1)),plim(2)));
    y = flipdim(y,1);
    imagesc(y);colormap('gray');
%     fx=linspace(0,8000,8);
    
%    xlabel(['Time (s)']);
%    ylabel(['Frequency (kHz)']);
    ylim=get(gca,['ylim']);
    xlim=get(gca,['xlim']);
      set(gca,'xtick',[xlim(1):(xlim(2)-xlim(1))/4:xlim(2)]);
      set(gca,'ytick',[ylim(1):(ylim(2)-ylim(1))/4:ylim(2)]);
      xt = get(gca,['XTickLabel']);

      set(gca,'XTickLabel',['0  ';'0.5';' 1 ';'1.5';'  2']);
      set(gca,'YTickLabel',['8';'6';'4';'2';'0']);
%     set(gca,'xtick',[0 0.5 1 1.5 2],'xticklabel',['0','0.5','1','1.5','2']);
%     set(gca,'xtick',[0:0.5:2],'xticklabel',['0','0.5','1','1.5','2']);
%     set(gca,'ytick',[6,4,2,0]);
%     set(gca,'YTick',ytick(msk),'YTickLabel',ytickl(msk));
%     imagesc(ff);
end
    
    
    
