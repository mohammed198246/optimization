clc; clear; close all;

syms a b h l1 l2 l3 l4 z1 z2 z3 z4 p1 p2 p3 p4 dL
variables = [a b h l1 l2 l3 l4 z1 z2 z3 z4 p1 p2 p3 p4];
V = (30-a)*(50-b)*h;                     % Target Function (Volume)
p1 = a-30+z1^2 == 0;                     % Constrains
p2 = b-50+z2^2 == 0;
p3 = h-50*a-50*b+z3^2 == 0;
p4 = -50*a-30*b+a*b+750+z4^2 == 0;
L = V+l1*lhs(p1)+l2*lhs(p2)+l3*lhs(p3)+l4*lhs(p4); % Langrange function

%series1: %E1:dL/da  %E2:dL/db  %E3:dL/dh
%series2: %E4:dL/dl1 %E5:dL/dl2 %E6:dL/dl3  %E7:dL/dl4 
%series3: %E8:dL/dz1 %E9:dL/dz2 %E10:dL/dz3 %E11:dL/dz4 
%series4: %E12:l1<0  %E13:l2<0  %E14:l3<0   %E15:l4<0
for i=1:15
    sym = variables(i);
    dL(i) = diff(L,sym) == 0;  %#ok    % derivative of L respect to variables
end

Sol=solve(dL,variables,'Real', true);% solve the system of equations

a  = double(Sol.a) ;  b = double(Sol.b) ; h  = double(Sol.h) ; 
l1 = double(Sol.l1); l2 = double(Sol.l2); l3 = double(Sol.l3); l4 = double(Sol.l4); 
z1 = double(Sol.z1); z2 = double(Sol.z2); z3 = double(Sol.z3); z4 = double(Sol.z4); 
p1 = double(Sol.p1); p2 = double(Sol.p2); p3 = double(Sol.p3); p4 = double(Sol.p4); 

answer_sets = [a b h l1 l2 l3 l4 z1 z2 z3 z4 p1 p2 p3 p4];

for i=1:numel(a)
    Case=answer_sets(i,:);
    P1=subs(p1,variables,Case);
    P2=subs(p2,variables,Case);
    P3=subs(p3,variables,Case);
    P4=subs(p4,variables,Case);
    if abs(P1)+abs(P2)+abs(P3)+abs(P4)==0 
        if a(i)>0 && b(i)>0 && h(i)>0
            if l1(i)<=0 && l2(i)<=0 && l3(i)<=0 && l4(i)<=0 
                Case
                V = (30-a(i))*(50-b(i))*h(i)
            end
        end
    end
end








