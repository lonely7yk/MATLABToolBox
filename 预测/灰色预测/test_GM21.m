clc,clear('all');
x0 = [41,49,61,78,96,104];	% 原始序列
num = 6;
[yuce,yuce_before,epsilon,delta] = GM21(x0,num)