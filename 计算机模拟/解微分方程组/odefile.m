% 微分方程表达式见卓金武 P215

% 微分方程组求解主程序
clc,clear
close all

T1 = clock;	 	% clock 返回一个行向量 clock = [year month day hour minute seconds]
disp('计算机正在准备输出湖泊有机物新陈代谢结果，请耐心等待……');
[tt, y] = ode45('lbwfun', [0:10:2020], [95.9,0.83,0.003,0.0001,0.0,0.0]);
t = tt(191:end, :);
ys = y(191:end, 1);
yp = y(191:end, 2);
yh = y(191:end, 3);
yr = y(191:end, 4);
yo = y(191:end, 5);
ye = y(191:end, 6);
T2 = clock;
API_elapsed_time = T2 - T1;	% 流逝的秒数

if API_elapsed_time(6) < 0	% 如果已经过了 1 分钟就把这 1 分钟的秒数补上
	API_elapsed_time(6) = API_elapsed_time(6) + 60;
	API_elapsed_time(5) = API_elapsed_time(5) - 1;
end

if API_elapsed_time(5) < 0	
	API_elapsed_time(5) = API_elapsed_time(5) + 60;
	API_elapsed_time(4) = API_elapsed_time(4) - 1;
end

if API_elapsed_time(4) < 0	
	API_elapsed_time(4) = API_elapsed_time(4) + 60;
	API_elapsed_time(3) = API_elapsed_time(3) - 1;
end

str = sprintf('湖泊新陈代谢模拟程序共运行 %d 小时 %d 分钟 %.4f 秒', ...
	API_elapsed_time(4), API_elapsed_time(5), API_elapsed_time(6));
disp(str);

result = [t, ys, yp, yh, yr, yo, ye]