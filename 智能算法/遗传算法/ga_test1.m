clc,clear
close all

fitnessfcn = @GA_demo;
nvars = 2;
options = gaoptimset('PopulationSize',100,'EliteCount',10,'CrossoverFraction', ...
	0.75,'Generations',500,'StallGenLimit',500,'TolFun',1e-100,'PlotFcns',...
	{@gaplotbestf,@gaplotbestindiv});
[x_best,fval] = ga(fitnessfcn,nvars,[],[],[],[],[],[],[],options);
% fitnessfcn([1 2])

%% GA_demo: 
function [f] = GA_demo(x)
	f1 = 4 * x(1).^3 + 4 * x(1) * x(2) + 2 * x(2).^2 - 42 * x(1) - 14;
	f2 = 4 * x(2).^3 + 4 * x(1) * x(2) + 2 * x(1).^2 - 26 * x(1) - 22;
	f = f1.^2 + f2.^2;
end