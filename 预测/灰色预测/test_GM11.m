clc,clear('all');
x0 = [71.1 72.4 72.4 72.1 71.4 72.0 71.6];
num = 7;
plus = 0;
[yuce_after,yuce,epsilon,delta,rho] = GM11(x0,num,plus)
% [yuce,yuce_before,epsilon,delta] = GM21(x0,num)