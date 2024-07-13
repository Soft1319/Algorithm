clear
clc
close all
addpath(genpath(pwd));
number=29; %选定优化函数，自行替换:F1，F3~F30,F2函数已被删除
variables_no = 30; % 可选 2, 10, 30, 50, 100
[lower_bound,upper_bound,variables_no,fobj]=Get_Functions_cec2017(number,variables_no);  % [lb,ub,D,y]：下界、上界、维度、目标函数表达式
pop_size=30;                      % population members 
max_iter=1000;                  % maximum number of iteration
%% SSCSO
[SSCSO_Best_score,Best_pos,SSCSO_curve]=SSCSO(pop_size,max_iter,lower_bound,upper_bound,variables_no,fobj);  % Calculating the solution of the given problem using SSCSO 
display(['The best optimal value of the objective funciton found by SSCSO  for ' [num2str(number)],'  is : ', num2str(SSCSO_Best_score)]);
%% DBO
[DBO_Best_score,Best_pos,DBO_curve]=DBO(pop_size,max_iter,lower_bound,upper_bound,variables_no,fobj);  % Calculating the solution of the given problem using DBO 
display(['The best optimal value of the objective funciton found by DBO  for ' [num2str(number)],'  is : ', num2str(DBO_Best_score)]);
% %% POA
% [POA_Best_score,~,POA_curve]=POA(pop_size,max_iter,lower_bound,upper_bound,variables_no,fobj);
% display(['The best optimal value of the objective funciton found by POA  for ' [num2str(number)],'  is : ', num2str(POA_Best_score)]);
%% SCSO
[SCSO_Best_score,~,SCSO_curve]=SCSO(pop_size,max_iter,lower_bound,upper_bound,variables_no,fobj);
display(['The best optimal value of the objective funciton found by SCSO  for ' [num2str(number)],'  is : ', num2str(SCSO_Best_score)]);
%% HHO
[HHO_Best_score,~,HHO_curve]=HHO(pop_size,max_iter,lower_bound,upper_bound,variables_no,fobj);
display(['The best optimal value of the objective funciton found by HHO  for ' [num2str(number)],'  is : ', num2str(HHO_Best_score)]);
%% SSA
[SSA_Best_score,~,SSA_curve]=SSA(pop_size,max_iter,lower_bound,upper_bound,variables_no,fobj);
display(['The best optimal value of the objective funciton found by SSA  for ' [num2str(number)],'  is : ', num2str(SSA_Best_score)]);
%% SABO
[SABO_Best_score,~,SABO_curve]=SABO(pop_size,max_iter,lower_bound,upper_bound,variables_no,fobj);
display(['The best optimal value of the objective funciton found by SABO  for ' [num2str(number)],'  is : ', num2str(SABO_Best_score)]);
%% MSCSO
[MSCSO_Best_score,~,MSCSO_curve]=MSCSO(pop_size,max_iter,lower_bound,upper_bound,variables_no,fobj);
display(['The best optimal value of the objective funciton found by MSCSO  for ' [num2str(number)],'  is : ', num2str(MSCSO_Best_score)]);
%% Figure
figure
CNT=20;
k=round(linspace(1,max_iter,CNT)); %随机选CNT个点
% 注意：如果收敛曲线画出来的点很少，随机点很稀疏，说明点取少了，这时应增加取点的数量，100、200、300等，逐渐增加
% 相反，如果收敛曲线上的随机点非常密集，说明点取多了，此时要减少取点数量
iter=1:1:max_iter;
   semilogy(iter(k),DBO_curve(k),'k-o','linewidth',1);
    hold on
    semilogy(iter(k),SABO_curve(k),'c-v','linewidth',1);
    hold on
    semilogy(iter(k),SSA_curve(k),'b-^','linewidth',1);
    hold on
    semilogy(iter(k),HHO_curve(k),'m-*','linewidth',1);
    hold on
    semilogy(iter(k),SCSO_curve(k),'y-p','linewidth',1);
    hold on
    semilogy(iter(k),MSCSO_curve(k),'r-o','linewidth',1);
    hold on
    semilogy(iter(k),SSCSO_curve(k),'g-x','linewidth',1);
    
grid on;
%%title(['F',num2str(number),',dim=',num2str(variables_no)])
title(['F',num2str(number)])
xlabel('Iteration');
ylabel('Best score obtained so far');
box on
legend('DBO','SABO','SSA','HHO','SCSO','MSCSO','SSCSO')
set (gcf,'position', [300,300,400,330])

rmpath(genpath(pwd))


