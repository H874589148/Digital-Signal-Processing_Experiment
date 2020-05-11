clear all;
close all;
x=-2:.2:2;
y=-2:.2:2;
[X,Y] = meshgrid(x,y);                                
Z = X .* exp(-X.^2 - Y.^2);
surf(X,Y,Z)