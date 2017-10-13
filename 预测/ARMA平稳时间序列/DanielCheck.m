clc,clear('all');
a = [15.2 15.9 18.7 22.4 26.9 28.3 30.5
33.8 40.4 50.7 58 66.7 81.2 83.4];
a = a'; a = a(:); a = a';	% 把原始数据变成一个行向量
% a = [0.7000    2.8000    3.7000    4.5000    1.4000    2.2000    3.3000    6.6000   10.3000    7.3000    8.7000   14.5000    2.2000];
% a = [2.1000    0.9000    0.8000   -3.1000    0.8000    1.1000    3.3000    3.7000   -3.0000    1.4000    5.8000  -12.3000];
num = 3;	% 预测步数
step = 0;
temp = a
while true
	Rt = tiedrank(temp)
	n = length(temp); t = 1:n;
	Qs = 1 - 6 / (n * (n^2 - 1)) * sum((t - Rt).^2)	% 计算 Qs
	t = Qs * sqrt(n - 2) / sqrt(1 - Qs^2)		% T 统计量
	t_0 = tinv(0.975,n-2)

	if abs(t) < t_0
		break
	end

	step = step + 1;	% 阶数加一
	b{step} = diff(temp);		% 求原始序列的一阶差分
	temp = b{step};
end

fprintf(['阶数为 ',num2str(step)])

%% ******************************** 修改这里 *********************************
m = armax(b{step}',[2,0])	% 利用最小二乘法估计模型参数

temp2 = b;
temp3 = a;
bp = predict(m,[temp2{step},0]',1);
temp2{step} = bp';
for i = step-1:-1:1
	temp2{i}(2:end+1) = temp2{i+1} + temp2{i};
end
temp3 = [temp3(1),temp3 + temp2{1}];
delta = abs((temp3(1:end-1) - a) ./ a)

for i = 1:num
	% 1 步预测，样本数据必须为列向量，要预测 1 个值，x 后要加一个任意数，
	% 1 步预测要用到 t - 1 步的数据
	bp = predict(m,[b{step},0]',1);
	bhat = bp(end);
	b{step} = [b{step},bhat];
	for i = step-1:-1:1
		b{i} = [b{i},b{i+1}(end) + b{i}(end)];
	end
	a = [a,a(end) + b{1}(end)];
end