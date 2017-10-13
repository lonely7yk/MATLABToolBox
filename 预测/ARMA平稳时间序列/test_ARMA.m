clc,clear
elps = randn(10000,1);
x = zeros(1, 10000);
for i = 2:10000
	x(i) = 0.8 * x(i-1) + elps(i) - 0.4 * elps(i-1);
end
x = x';