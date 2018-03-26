clc,clear
close all

[trace,noteExtrem,extremY,extremX] = GA_Sheffield(2,[-3.0 4.1],[12.1 5.8],1);

% 遗传参数（请根据具体情况修改！！）
NIND = 40;		% 种群大小
NVAR = 2;		% 变量的维数
MAXGEN = 500;	% 最大遗传代数
PRECI = 20;		% 个体长度
GGAP = 0.9;		% 代沟
MP = 10;		% 种群数目
lb = [-3 4.1];
ub = [12.1 5.8];
% 区域描述器 1：个体长度 2、3：上下界 4：编码方式（1为二进制 0为格雷码）
% 5：子串使用刻度（0为算数 1为对数） 6、7：范围是否包含边界（1为是 0为否）
FiledD = [repmat(PRECI,1,NVAR);lb;ub; repmat([1;0;1;1],[1,NVAR])];
for i = 1:MP
	Chrom{i} = crtbp(NIND,NVAR * PRECI);
end
pc = 0.7 + (0.9 - 0.7) * rand(MP,1);		% 交叉概率在 [0.7,0.9]
pm = 0.001 + (0.05 - 0.001) * rand(MP,1);	% 变异概率在 [0.001,0.05]
gen = 0;
gen0 = 0;
MAXGEN = 10;
maxY = 0;
for i = 1:MP
	X = bs2rv(Chrom{i},FiledD);	
	ObjV{i} = Fitness(X);
end
MaxObjV = zeros(MP,1);
MaxChrom = zeros(MP,PRECI * NVAR);
while gen0 <= MAXGEN
	gen = gen + 1;
	for i = 1:MP
		FitnV{i} = ranking(-ObjV{i});
		SelCh{i} = select('sus',Chrom{i},FitnV{i},GGAP);	% 选择操作
		SelCh{i} = recombin('xovsp',SelCh{i},pc(i));		% 交叉操作
		SelCh{i} = mut(SelCh{i},pm(i));						% 变异操作
		X = bs2rv(SelCh{i},FiledD);	
		ObjVSel = Fitness(X);		% 子代目标函数值
		[Chrom{i},ObjV{i}] = reins(Chrom{i},SelCh{i},1,1,ObjV{i},ObjVSel);	% 重插入
	end
	[Chrom,ObjV] = immigrant(Chrom,ObjV);		% 移民操作
	[MaxObjV,MaxChrom] = EliteInduvidual(Chrom,ObjV,MaxObjV,MaxChrom);	% 人工选择精华种群
	YY(gen) = max(MaxObjV);						% 找出精华种群中的最优的个体
	% 判断当前优化值是否与前一次优化值相同
	if YY(gen) > maxY
		maxY = YY(gen);
		gen0 = 0;
	else
		gen0 = gen0 + 1;
	end
end
plot(1:gen,YY)	% 进化图
xlabel('进化代数')
ylabel('最优解变化')
title('进化过程')
xlim([1,gen])

[Y,I] = max(MaxObjV);		% 找出精华种群最优个体
X = bs2rv(MaxChrom(I,:),FiledD);		% 最优个体的解码解

%% GA_Sheffield: 谢菲尔德工具箱遗传算法
% 千万注意是求最大值还是最小值需要改变 ranking 括号里的正负 和 '[Y,I] = min(ObjV);'
function [trace,noteExtrem,extremY,extremX] = GA_Sheffield(nvars,lb,ub,command)
	% input
	% nvars = 2;		% 变量数量
	% lb = [0 0]; ub = [10 10]; % lb 为变量下限，ub 为上限，均为行向量，长度与 nvars 相等
	% command : 0 表示求最小值，1 表示求最大值，默认为 0
	% output
	% trace : n+1 行，表示 n 个变量和 1 个结果；MAXGEN 列，每列表示一代的结果
	
	if nargin < 4
		command = 0;
	end
	
	% 遗传参数（请根据具体情况修改！！）
	NIND = 40;		% 种群大小
	MAXGEN = 500;	% 最大遗传代数
	PRECI = 20;		% 个体长度
	GGAP = 0.9;	% 代沟
	px = 0.7;		% 交叉概率
	pm = 0.05;		% 变异概率
	trace = zeros(nvars+1,MAXGEN);	% 寻优过程因变量和自变量
	noteExtrem = zeros(nvars+1,MAXGEN);	% 寻优过程最优因变量和自变量
	
	% 区域描述器 1：个体长度 2、3：上下界 4：编码方式（1为二进制 0为格雷码）
	% 5：子串使用刻度（0为算数 1为对数） 6、7：范围是否包含边界（1为是 0为否）
	FiledD = [repmat(PRECI,1,nvars);lb;ub; repmat([1;0;1;1],[1,nvars])];	
	Chrom = crtbp(NIND,PRECI * nvars);		% 随机种群（40 * 20）
	
	gen = 0;
	X = bs2rv(Chrom,FiledD);
	ObjV = Fitness(X);		% Fitness 需根据需求重写

	if command == 0
		extremY = inf;	% 求最小值
	else
		extremY = 0;	% 求最大值
	end

	extremX = zeros(1,nvars);	% 取到最大或最小时的 X 取值
	while gen < MAXGEN
		if command == 1
			temp_ObjV = -ObjV;	% 如果计算最大值就取相反数
		end
		FitnV = ranking(temp_ObjV);					% 适应度值（适应度越大个体越好，越有可能被选中）
		SelCh = select('sus',Chrom,FitnV,GGAP);	% 选择
		SelCh = recombin('xovsp',SelCh,px);		% 重组
		SelCh = mut(SelCh,pm);					% 变异
		X = bs2rv(SelCh,FiledD);				% 子代个体的十进制转换
	    ObjVSel = Fitness(X);
		[Chrom,ObjV] = reins(Chrom,SelCh,1,1,ObjV,ObjVSel);	% 重插入
		X = bs2rv(Chrom,FiledD);
		gen = gen + 1;

		if command == 0
			[Y,I] = min(ObjV);
			% 求最小值
			if extremY > Y
				extremY = Y;
				extremX = X(I,:);
			end
		else
			[Y,I] = max(ObjV);
			% 求最大值
			if extremY < Y
				extremY = Y;
				extremX = X(I,:);
			end
		end

		trace(1:end-1,gen) = X(I,:);	% 当代最优值对应的 X
		trace(end,gen) = Y;		% 当代最优值对应的 Y
		
		noteExtrem(1:end-1,gen) = extremX;
		noteExtrem(end,gen) = extremY;
	end
	
	% hold on
	plot(1:MAXGEN,noteExtrem(end,:));
end

%% Fitness: 适应度函数
function [ObjV] = Fitness(X)
	col = size(X,1);
	for i = 1:col
		ObjV(i,1) = 21.5 + X(i,1) * sin(4 * pi * X(i,1)) + X(i,2) * sin(20 * pi * X(i,2));
	end
end

%% EliteInduvidual: 人工选择算子
function [MaxObjV,MaxChrom] = EliteInduvidual(Chrom,ObjV,MaxObjV,MaxChrom)
	MP = length(Chrom);
	for i = 1:MP
		[MaxO,maxI] = max(ObjV{i});		% 找出第 i 种群中最优的个体
		if MaxO > MaxObjV(i)
			MaxObjV(i) = MaxO;				% 记录各种群的精华个体
			MaxChrom(i,:) = Chrom{i}(maxI,:);	% 记录各种群精华个体的编码
		end
	end
end

%% immigrant: 移民算子
function [Chrom,ObjV] = immigrant(Chrom,ObjV)
	MP = length(Chrom);
	for i = 1:MP
		[MaxO,maxI] = max(ObjV{i});		% 找出第 i 种群中最优的个体
		next_i = i + 1;
		if next_i > MP
			next_i = mod(next_i,MP);
		end
		[MinO,minI] = min(ObjV{next_i});	% 找出目标种群中最劣的个体
		% 目标种群最劣个体替换为源种群最优个体
		Chrom{next_i}(minI,:) = Chrom{i}(maxI,:);
		ObjV{next_i}(minI) = ObjV{i}(maxI);
	end
end