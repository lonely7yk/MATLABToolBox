clc,clear('all');
data0 = textread('zhu.txt');
data = [data0(:,1:5);data0(:,6:10)];
data(end,:) = [];
x123 = data(:,3:5);	% 影响瘦肉量的三个变量
X = [ones(size(x123,1),1),x123];
Y = data(:,2);		% 瘦肉量

[b,bint,r,rint,stats,result] = LinearRegress(Y,X)
% rstool(x123,Y)