%% 一元：求 y = sin(10 * pi * x) / x 在[1,2]上的最小值 

clc,clear('all');
figure(1);
hold on

%% ******************************** 函数图 *********************************
lb = 1; ub = 2;
ezplot('sin(10 * pi * X) / X',[lb,ub]);
xlabel('自变量')
ylabel('因变量')

%% ******************************** 遗传算法参数 *********************************
NIND = 40;		% 种群大小
MAXGEN = 20;	% 最大遗传代数
PRECI = 20;		% 个体长度
GGAP = 0.95;	% 代沟
px = 0.7;		% 交叉概率
pm = 0.01;		% 变异概率
trace = zeros(2,MAXGEN);	% 寻优结果初始值

% 区域描述器 1：个体长度 2、3：上下界 4：编码方式（1为二进制 0为格雷码）
% 5：子串使用刻度（0为算数 1为对数） 6、7：范围是否包含边界（1为是 0为否）
FiledD = [PRECI;lb;ub;1;0;1;1];	
Chrom = crtbp(NIND,PRECI);		% 随机种群（40 * 20）

%% ******************************** 优化 *********************************
gen = 0;	% 代数计数器
X = bs2rv(Chrom,FiledD);	% 初始种群二进制到十进制转换
ObjV = sin(10 * pi * X) ./ X;	% 目标函数值（40 * 1）
while gen < MAXGEN
	FitnV = ranking(ObjV);		% 适应度值（适应度越大个体越好，越有可能被选中）
	SelCh = select('sus',Chrom,FitnV,GGAP);	% 选择
	SelCh = recombin('xovsp',SelCh,px);		% 重组
	SelCh = mut(SelCh,pm);					% 变异
	X = bs2rv(SelCh,FiledD);				% 子代个体的十进制转换
	ObjVSel = sin(10 * pi * X) ./ X;				% 子代的目标数值
	[Chrom,ObjV] = reins(Chrom,SelCh,1,1,ObjV,ObjVSel);	% 重插入
	X = bs2rv(Chrom,FiledD);
	gen = gen + 1;

	[Y,I] = min(ObjV);
	trace(1,gen) = X(I);	% 当代最优值对应的 X
	trace(2,gen) = Y;		% 当代最优值对应的 Y
end

plot(trace(1,:),trace(2,:),'bo');
grid on;
plot(X,ObjV,'r*');

%% ******************************** 进化图 *********************************
figure(2)
plot(1:MAXGEN,trace(2,:));
grid on
xlabel('遗传代数')
ylabel('解的变化')
title('变化过程')

%% ******************************** 输出结果 *********************************
bestY = trace(2,end);
bestX = trace(1,end);
fprintf(['最优解为\nY = ',num2str(bestY),'\nX = ',num2str(bestX),'\n'])