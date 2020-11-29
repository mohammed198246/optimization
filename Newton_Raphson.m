% The functions returns the solution of three equations in three variables using newton Raphson method.
% The inputs are symbolic functions, initial guesses and number of iterations.


function [Solution,Val]=Newton_Raphson(sys,variables,point,MaxIter)
    J= jacobian(sys',variables);
    Iter=0; Val=100;
    while Iter<MaxIter && max(abs(Val))>10e-10
        A=subs(J,variables,point);
        Val=subs(sys,variables,point);
        point=double(point'-A^-1*Val')';
        Iter=Iter+1;
    end
    Solution=point;
end