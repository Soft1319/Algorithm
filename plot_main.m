clear all; close all; clc;
%% 数据 % m * n的矩阵，m对应的是一共有几堆，n对应的是每堆有几个柱子
%data_mean = [212,238,250;212,238,250;212,238,250;212,238,250];

%% HC_AD
data_mean_HC_AD = [];
data_std_HC_AD = [];
%data_std = [56,65,59;56,65,59;56,65,59;56,65,59];

%% EMCI_AD
data_mean_EMCI_AD = [];
data_std_EMCI_AD = [];

%% LMCI_AD
data_mean_LMCI_AD = [];
data_std_LMCI_AD = [];

%% EMCI_LMCI
data_mean_EMCI_LMCI = [];
data_std_EMCI_LMCI = [];

%% HC_EMCI
data_mean_HC_EMCI = [];
data_std_HC_EMCI = [];

%% HC_LMCI
data_mean_HC_LMCI = [];
data_std_HC_LMCI = [];


%% 颜色选择 根据自己的需求选择
RGB1 = cbrewer2('seq', 'Blues', 12, 'linear');
RGB2 = cbrewer2('seq', 'Greens', 12, 'linear');
RGB3 = cbrewer2('seq', 'Purples', 12, 'linear');
RGB4 = cbrewer2('seq', 'Greys', 12, 'linear');
RGB1  = RGB1([5,7,8,9],:);
RGB2  = RGB2([5,7,8,9],:);
RGB3  = RGB3([5,7,8,9],:);
RGB4  = RGB4([5,7,8,9],:);
RGB = cat(3,RGB1,RGB2,RGB3,RGB4);
%% 绘图
figure
y = data_mean_HC_AD; 
neg = data_std_HC_AD; 
pos = data_std_HC_AD; 
m = size(y,1);
n = size(y,2);
x = 1 : m;
h = bar(x, y);
%% 单独设置第i个组第j个柱子的颜色
for i = 1 : m
    for j = 1 : n
        h(1, j).FaceColor = 'flat';
        h(1, j).CData(i,:) = squeeze(RGB(j,:,i));
        h(1,j).EdgeColor = 'flat';
    end
end
%% 获取误差线 x 值
xx = zeros(m, n);
for i = 1 : n
    xx(:, i) = h(1, i).XEndPoints';
end
% 绘制误差线
hold on
errorbar(xx, y, neg, pos, 'LineStyle', 'none', 'Color', 'k', 'LineWidth', 1);
hold off
%% 设置figure的格式
% matlab中默认字体是 Arial 8 号
% 设置xticklabels和yticklabels的字体以及字体的大小
set(gca, 'FontSize',13);
set(gca,'FontName','Times New Roman');
% 设置 x 轴 xticklabels
set(gca, 'XTickLabel', {'\fontname{Times New Roman}ACC', ...
    '\fontname{Times New Roman}sensitivity', ...
    '\fontname{Times New Roman}specificity', ...
    '\fontname{Times New Roman}MCC', ...
    '\fontname{Times New Roman}precision', ...
    '\fontname{Times New Roman}F1-measure'}, 'FontSize',13);
% xticks([]) %如果不想设置xticklabels，使用该命令
% 设置legend图例
% 设置 y 轴标签
ylabel('\fontname{Times New Roman}y\fontname{宋体}轴标签','FontSize',15);
% 设置y轴范围
ylim([0 1.2])
% 去除上边界和右边界
box off
% 设置边框的粗细
set(gca,'XColor','k','YColor','k','linewidth',1);