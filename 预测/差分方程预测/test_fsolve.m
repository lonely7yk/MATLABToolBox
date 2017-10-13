clc,clear('all');
M = 600; N = 420; p = 200; q = 2282;
eq = @(x) x^M - (1 + q / p) * x^(M - N) + q / p;
options = optimset('MaxFunEvals',10000,'MaxIter',1000);
x0 = 1.2345;
x = fsolve(eq,x0,options)