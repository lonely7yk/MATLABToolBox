%% StepTraverse: 逐步遍历（找差距最小值）
function [minTarget,minDelta] = StepTraverse(left,right,best,func)
	% input
	% left : 初始左边界
	% right : 初始右边界
	% best : 最优解
	% func : 函数句柄（需要补充）
	% output
	% minTarget : best 对应的自变量
	% minDelta : 与最优解的误差

	minDelta = inf;
	for i = 1:4
		step_length = 0.1^(i-1);
		for j = left:step_length:right
			curDays = func(...);		% 这里需要补充		
			curDelta = abs(curDays - best);		% 当前的差距
	
			if curDelta < minDelta
				minDelta = curDelta;
				minTarget = j;
				left = j - step_length;
				right = j + step_length;
			end
		end
	end
	if minDelta > 0.1		% 如果误差过大抛出异常
		error('误差过大\n');
	end
end