%% YinZiMatrix: 输入协方差矩阵，即可通过主成分分析法输出
%% 未经旋转的 num 个因子的因子载荷矩阵，A 为因子载荷矩阵
%% B 为 num 个因子的载荷矩阵， rate 为贡献率
function [A,B,rate] = YinZiMatrix(r,num)	% r 为协方差矩阵
	[vec1,val,rate] = pcacov(r);
	f1 = repmat(sign(sum(vec1)), size(vec1,1), 1);
	vec2 = vec1.*f1;
	f2 = repmat(sqrt(val)', size(vec2,1), 1);
	A = f2.*vec2; 	% 计算因子载荷矩阵
    B = A(:,1:num); % 提出 num 个因子的载荷矩阵 
end
