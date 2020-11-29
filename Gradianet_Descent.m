clc; clear; close all;

syms X Y;
variables = [X,Y];
f = X-Y+2*X^2+2*X*Y+Y^2;                    % Function Definition 

x(1)=1; y(1)=-5;                            % Initial Guess
e=10e-8;                                    % Convergence Criteria
i=1;                                        % Iteration Counter

df_dx = diff(f,X);                          % Gradient Computation
df_dy = diff(f,Y);
J = [subs(df_dx,variables,[x(1),y(1)])...
     subs(df_dy,variables,[x(1),y(1)])];    % Gradient
S = -(J);                                   % Search Direction

while norm(J) > e 
    I = [x(i),y(i)]';
    syms h;                                 % Step size
    g = subs(f,variables,[x(i)+S(1)*h,y(i)+h*S(2)]);
    dg_dh = diff(g,h);
    h = solve(dg_dh,h);                     % Optimal Step Length
    x(i+1) = I(1)+h*S(1);                   % Updated x value
    y(i+1) = I(2)+h*S(2);                   % Updated y value
    i = i+1;
    J = [subs(df_dx,variables,[x(i),y(i)])...
         subs(df_dy,variables,[x(i),y(i)])];% Updated Gradient
    S = -(J);                               % New Search Direction
end

% Result Table:
Iter = 1:i;
X_coordinate = x'; Y_coordinate = y'; Iterations = Iter';
T = table(Iterations,X_coordinate,Y_coordinate);

fcontour(f,'Fill','On'); hold on; plot(x,y,'*-r');

fprintf('Initial Objective Function Value: %d\n\n',subs(f,variables, [x(1),y(1)]));
if (norm(J) < e)
    fprintf('Minimum succesfully obtained...\n\n');
end
fprintf('Number of Iterations for Convergence: %d\n\n', i);
fprintf('Point of Minima: [%d,%d]\n\n', x(i), y(i));
fprintf('Objective Function Minimum Value Post-Optimization: %d\n\n', subs(f,variables, [x(i),y(i)]));
disp(T);
