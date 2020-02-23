
%   fig160201.m, for fig16.2.1
clear;
[h0 h1]=meshgrid(-25:2:25,-25:2:25);
%[h0 h1]=meshgrid(-50:2:50,-50:2:50);
error=0.34-0.6.*h0-h1+h0.*h0+h1.*h1;
%subplot(223)
mesh(h0,h1,error);
grid on;
title('Error Surface'); xlabel('h0'); ylabel('h1'); zlabel('MSE');


