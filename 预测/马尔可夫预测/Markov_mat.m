clc,clear('all');
format rat
a = [4 3 2 1 4 3 1 1 2 3
2 1 2 3 4 4 3 3 1 1
1 3 3 2 1 2 2 2 4 4
2 3 2 3 1 1 2 4 3 1];
a = a';
a = a(:)';	% 把矩阵 a 逐行展开成一个行向量
for i = 1:4
	for j = 1:4
		f(i,j) = length(findstr([i j],a));	% 统计子字符串 'ij' 的个数
	end
end
ni = sum(f,2);	% 计算矩阵 f 的行和
phat = f ./ repmat(ni,1,size(f,2))	% 求状态转移概率

format