%--------------------------------------------------------------------------
%             森林火灾
%--------------------------------------------------------------------------

% 有三种不同的状态，0 为空，1 为燃烧，2 为森林

clc,clear
close all

n = 100;

Plightning = 0.000005;		% 闪电击中导致自身燃烧的概率
Pgrowth = 0.01;				% 空单元格成为森林的概率

z = zeros(n,n);
o = ones(n,n);
veg = z;
sum = z;

imh = image(cat(3,z,veg*0.02,z));
set(imh,'erasemode','none')
axis equal
axis tight

% burning -> empty
% green -> burning if one neigbor burning or with prob=f (lightning)
% empty -> green with prob=b (growth)
% veg = {empty=0 burning=1 green=2}
for i = 1:3000
	sum = (veg(1:n,[n 1:n-1]) == 1) + (veg(1:n,[2:n 1]) == 1) + ...
			(veg([n 1:n-1],1:n) == 1) + (veg([2:n 1],1:n) == 1);

	veg = 2 * (veg == 2) - ((veg == 2) & (sum > 0 | (rand(n,n) < Plightning))) + ...
			2 * ((veg == 0) & rand(n,n) < Pgrowth);

	set(imh,'cdata',cat(3,(veg == 1),(veg == 2),z))
	drawnow
end