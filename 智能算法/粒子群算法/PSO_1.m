clc,clear
close all

%% ******************************** 参数初始化 *********************************
x_range = [-50 50];			% 参数 x 的范围
y_range = [-50 50];			% 参数 y 的范围
range = [x_range;y_range];	% 参数变化矩阵
Max_V = 0.2 * (range(:,2) - range(:,1));	% 最大速度
n = 2;				% 函数维数

% 算法参数
PSOparams = [25 2000 24 2 2 0.9 0.4 1500 1e-25 250 NaN 0 0];

% 调用工具箱
% pso_Trelea_vectorized('test_func',n,Max_V,range,0,PSOparams)
pso_Trelea_vectorized('test_func',n,Max_V,range)

