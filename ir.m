function IR=ir(f,p,x2_0,T)
%IR=ir(f,p,x2_0,T)
%This program computes T-period impulse responses for 
% the system:
% x2(t+1) = p x2(t)
% x1(t) = f x2(t)
% with initial condition x2_0
% Inputs: f, p, x2_0, and (optional) T
% (c) Stephanie Schmitt-Grohe and Martin Uribe
% September 19, 2001


if nargin < 4
T =10;
end 

x2_0=x2_0(:);
pd=length(x2_0);
MX=[f;eye(pd)];
IR=[];
x2=x2_0;
for t=1:T
IR(t,:)=(MX*x2)';
x2 = p * x2;
end