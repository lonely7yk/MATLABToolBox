clc,clear('all');
x0 = [2.874,3.278,3.39 3.679,3.77,3.8];	% 原始数据
num = 6;
[yuce,yuce_before,epsilon,delta] = DGM21(x0,num)
% [yuce,yuce_before,epsilon,delta] = GM11(x0,num)