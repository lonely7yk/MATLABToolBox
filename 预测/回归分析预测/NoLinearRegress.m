%% NoLinearRegress: 非线性规划分析
function [beta,betaci,yhat,eplison,delta,radius] = NoLinearRegress(x,y,f,beta0)

	[beta,r,j] = nlinfit(x,y,f,beta0)  %计算回归系数beta; r,j是下面命令用的信息
	betaci = nlparci(beta,r,'jacobian',j)  %计算回归系数的置信区间
	[yhat,radius] = nlpredci(f,x,beta,r,'jacobian',j) %计算y的预测值及置信区间半径，
	eplison = yhat - y;
	delta = abs(eplison ./ y);
end