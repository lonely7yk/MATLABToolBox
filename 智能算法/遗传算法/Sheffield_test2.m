%% 多元：求 z = x * cos(2 * pi * y) + y * sin(2 * pi * x) 在x[-2,2]  y[-2,2]上的最大值 

clc,clear('all');
figure(1);

%% 函数图
lbx = -2; ubx = 2;
lby = -2; uby = 2;
ezmesh('X*cos(2*pi*Y)+Y*sin(2*pi*X)',[lbx,ubx,lby,uby],50);

hold on
%% 遗传算法参数
NIND = 40;		% 种群大小
MAXGEN = 50;	% 最大遗传代数
PRECI = 20;		% 个体长度
GGAP = 0.95;	% 代沟
px = 0.7;		% 交叉概率
pm = 0.01;		% 变异概率
trace = zeros(3,MAXGEN);	% 寻优结果初始值

% 区域描述器 1：个体长度 2、3：上下界 4：编码方式（1为二进制 0为格雷码）
% 5：子串使用刻度（0为算数 1为对数） 6、7：范围是否包含边界（1为是 0为否）
FiledD = [PRECI PRECI;lbx lby;ubx uby; 1 1; 0 0; 1 1; 1 1];	
Chrom = crtbp(NIND,PRECI * 2);		% 随机种群（40 * (20 * 2)）

%% 优化
gen = 0;	% 代数计数器
XY = bs2rv(Chrom,FiledD);	% 初始种群二进制到十进制转换
X = XY(:,1);Y = XY(:,2);
ObjV = X .* cos(2 * pi * Y) + Y .* sin(2 * pi * X);	% 目标函数值（40 * 1）
while gen < MAXGEN
	FitnV = ranking(-ObjV);		% 适应度值（适应度越大个体越好，越有可能被选中）
	SelCh = select('sus',Chrom,FitnV,GGAP);	% 选择
	SelCh = recombin('xovsp',SelCh,px);		% 重组
	SelCh = mut(SelCh,pm);					% 变异
	XY = bs2rv(SelCh,FiledD);				% 子代个体的十进制转换
	X = XY(:,1);Y = XY(:,2);
	ObjVSel = X .* cos(2 * pi * Y) + Y .* sin(2 * pi * X);				% 子代的目标数值
	[Chrom,ObjV] = reins(Chrom,SelCh,1,1,ObjV,ObjVSel);	% 重插入
	XY = bs2rv(Chrom,FiledD);
	gen = gen + 1;

	[Z,I] = max(ObjV);
	trace(1:2,gen) = XY(I,:);	% 当代最优值对应的 X
	trace(3,gen) = Z;		% 当代最优值对应的 Y
end

plot3(trace(1,:),trace(2,:),trace(3,:),'bo');
grid on;
plot3(XY(:,1),XY(:,2),ObjV,'r*');
hold off

%% 进化图
figure(2)
plot(1:MAXGEN,trace(3,:));
grid on
xlabel('遗传代数')
ylabel('解的变化')
title('变化过程')
bestY = trace(2,end);
bestX = trace(1,end);
bestZ = trace(3,end);
fprintf(['最优解为\nZ = ',num2str(bestZ),'\nY = ',num2str(bestY),'\nX = ',num2str(bestX),'\n'])