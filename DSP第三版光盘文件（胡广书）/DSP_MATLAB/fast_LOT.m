%-------------------------------------------------------------------------
%  function subroutine: fast_lot.m, for fast LOT Algorithms,for M=8
%  Input parameter:
%      vector a -----In this program,
%	        if vector a is [0.13*pi 0.16*pi 0.13*pi],then 
%  	        it is a fast alogorithms for maximum coding gain;
%	        else vector a is [0.145*pi 0.17*pi 0.16*pi]
%  	        it is a fast alogorithms for the QR_based quasioptimal LOT.
%  Output parameter:
%       matrix P ------ a L*M transform matrix, each column of it is the LOT
%			basis function for each block;
%--------------------------------------------------------------------------
function P=fast_LOT(a)

M=8;
L=2*M;

% 以下算法见 8.8 节；
D=zeros(M,M);
for i=2:M
   for j=1:M
      D(i,j)=sqrt(2/M)*cos((2*(j-1)+1)*(i-1)*pi/(2*M));
   end
end
for j=1:M
   D(1,j)=sqrt(1/M)*cos((2*(j-1)+1)*(1-1)*pi/(2*M));
end
D=D';

J=zeros(M,M);
k=M;
for i=1:M
   J(i,k)=1;
   k=k-1;
end

De=zeros(M,M/2);
Do=zeros(M,M/2);
for i=1:M/2
   De(:,i)=D(:,(2*(i-1)+1));
   Do(:,i)=D(:,(2*i));
end

P0=zeros(L,M);
P0=[De-Do De-Do;J*(De-Do) -J*(De-Do)]/2;

for i=1:3
   y(:,:,i)=[cos(a(i)) sin(a(i));-sin(a(i)) cos(a(i))];
end
a=eye(2,2);
b=zeros(2,2);
b1=zeros(2,1);
T1=[y(:,:,1) b;b a];
T2=[1 b1' 0;b1 y(:,:,2) b1;0 b1' 1];
T3=[a b;b y(:,:,3) ];
Z1=T1*T2*T3;

A=eye(M/2,M/2);
B=zeros(M/2,M/2);
Z=[A B;B Z1];
P1=P0*Z;
P=zeros(size(P1));
P(:,1:2:7)=P1(:,1:4);
P(:,2:2:8)=P1(:,5:8);

