clc,clear('all');
format rat
p = [0.8 0.1 0.1
0.5 0.1 0.4
0.5 0.3 0.2];

[p_limit] = LimitProbability(p)