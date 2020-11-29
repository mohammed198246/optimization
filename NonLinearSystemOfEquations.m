clc; clear; close all;

syms x y z
variables=[x,y,z];

u=3*x-cos(y*z)-1.5; 
v=4*x-625*(y^2)+2*z-1; 
w=20*z+exp(-x*y)+9;
sys=[u,v,w];

MaxIter=20;
point=[1,2,3];
[Solution,Val] = Newton_Raphson(sys,variables,point,MaxIter);

Val=double(Val')
fprintf('X is %10.8f, Y is %10.8f and Z is %10.8f\n',Solution)