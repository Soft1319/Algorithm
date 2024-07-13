
% 此代码用于绘制各种混沌映射的图
clear
clc
close
numm = 3;  %% numm 混沌映射类型选择，1-10，tent、Logistic、Cubic、chebyshev、Piecewise、sinusoidal、Sine,ICMIC, Circle,Bernoulli，自由切换
x = chaos(numm,1000,1);  %
figure
plot(x,'.')
xlabel('维度')
ylabel('混沌值')

figure
hist(x)
xlabel('混沌值')
ylabel('频数')
