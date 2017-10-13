clc,clear
close all

syms t;
f = t^4 - t^2 - 2 * t + 5;
[x1,x2] = minJT(f,0,0.1)