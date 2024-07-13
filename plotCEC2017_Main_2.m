
%%
%%
clear
clc
close all
addpath(genpath(pwd));
number=18; %选定优化函数，自行替换:F1~F23
variables_no = 30; % 可选 2, 10, 30, 50, 100
[lower_bound,upper_bound,variables_no,fobj]=Get_Functions_cec2017(number,variables_no);  % [lb,ub,D,y]：下界、上界、维度、目标函数表达式
pop_size=30;                      % population members 
max_iter=1000;                  % maximum number of iteration
%% SSCSO
[SSCSO_Best_score,SS_SCSO_Best_pos,SSCSO_curve,Trajectories,fitness_history, position_history]=SSCSO(pop_size,max_iter,lower_bound,upper_bound,variables_no,fobj);  % Calculating the solution of the given problem using SSCSO 
display(['The best optimal value of the objective funciton found by SS-SCSO  for ' [num2str(number)],'  is : ', num2str(SSCSO_Best_score)]);
%% DBO
[DBO_Best_score,Best_pos,DBO_curve]=DBO(pop_size,max_iter,lower_bound,upper_bound,variables_no,fobj);  % Calculating the solution of the given problem using DBO 
display(['The best optimal value of the objective funciton found by DBO  for ' [num2str(number)],'  is : ', num2str(DBO_Best_score)]);
% %% POA
% [POA_Best_score,~,POA_curve]=POA(pop_size,max_iter,lower_bound,upper_bound,variables_no,fobj);
% display(['The best optimal value of the objective funciton found by POA  for ' [num2str(number)],'  is : ', num2str(POA_Best_score)]);
%% SCSO
[SCSO_Best_score,SCSO_Best_pos,SCSO_curve]=SCSO(pop_size,max_iter,lower_bound,upper_bound,variables_no,fobj);
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
[MSCSO_Best_score,MSCSO_Best_pos,MSCSO_curve]=MSCSO(pop_size,max_iter,lower_bound,upper_bound,variables_no,fobj);
display(['The best optimal value of the objective funciton found by MSCSO  for ' [num2str(number)],'  is : ', num2str(MSCSO_Best_score)]);
%% Figure

figure('Position',[50  200  1500 200])
set(gcf,'Color','white');
color1 = [205,92,92]/255;
color2 = [72,61,139]/255;
color3 = [0,206,209]/255;
color4 = [150,0,255]/255;
color5 = [3,10,10]/255;
color6 = [160,160,255]/255;
color7 = [0,180,180]/255;
color8 = [30,255,12]/255;
%% Draw search space
subplot(1,5,1);
func_plot_cec2017(number,30)
title('Parameter space','FontName', 'Times New Roman','FontWeight','bold')
xlabel('x_1','FontName', 'Times New Roman','FontWeight','bold');
ylabel('x_2','FontName', 'Times New Roman','FontWeight','bold');
zlabel(['F','( x_1 , x_2 )'],'FontName', 'Times New Roman','FontWeight','bold')
box on
axis tight


subplot(1,5,2);
semilogy(SSCSO_curve,'Color','g','linewidth',1);
hold on
semilogy(SCSO_curve,'Color','y','linewidth',1);
hold on
semilogy(MSCSO_curve,'Color','r','linewidth',1);

title('Convergence curve', 'FontName', 'Times New Roman','FontWeight','bold')
xlabel('Iteration', 'FontName', 'Times New Roman','FontWeight','bold');
ylabel('Best score obtained so far', 'FontName', 'Times New Roman','FontWeight','bold');
box on
legend('SS-SCSO','SCSO','MSCSO', 'FontName', 'Times New Roman')
axis tight


subplot(1,5,3);
hold on
semilogy(Trajectories(1,:),'Color',color5,'linewidth',2);
title('Trajectory ','FontName', 'Times New Roman','FontWeight','bold')
xlabel('Iteration','FontName', 'Times New Roman','FontWeight','bold')
box on
legend('SS-SCSO', 'FontName', 'Times New Roman')
axis tight


subplot(1,5,4);
hold on
a=mean(fitness_history);
semilogy(a,'Color',color2,'linewidth',2);
title('Average Fitness ','FontName', 'Times New Roman','FontWeight','bold')
xlabel('Iteration','FontName', 'Times New Roman','FontWeight','bold')
box on
legend('SS-SCSO', 'FontName', 'Times New Roman')
axis tight


subplot(1,5,5);
hold on
for k1 = 1: size(position_history,1)
    for k2 = 1: size(position_history,2)
        plot(position_history(k1,k2,1),position_history(k1,k2,2),'o','markersize',3,'MarkerEdgeColor','k','markerfacecolor','#1e90ff');
    end
end
plot(SS_SCSO_Best_pos(1),SS_SCSO_Best_pos(2),'o','markersize',7,'MarkerEdgeColor','k','markerfacecolor','r','linewidth',1);
title('Search history','FontName', 'Times New Roman','FontWeight','bold')
xlabel('x_1','FontName', 'Times New Roman','FontWeight','bold')
ylabel('x_2','FontName', 'Times New Roman','FontWeight','bold')
box on
axis tight
subplot(1,5,5);
hold on
%func_plot1(number)


