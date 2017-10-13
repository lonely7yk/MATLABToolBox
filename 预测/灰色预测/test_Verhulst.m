clc,clear('all');
x0 = [4.93 2.33 3.87 4.35 6.63 7.15 5.37 6.39 7.81 8.35];
num = 10;
% [yuce,yuce_before,epsilon,delta] = Verhulst(x0,num)
[yuce,yuce_before,epsilon,delta] = GM11(x0,num,100)