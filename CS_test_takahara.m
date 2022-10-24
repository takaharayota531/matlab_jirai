clc;clear;close all;
set(0,'defaultfigurecolor',[1 1 1]);
set(0,'defaultAxesFontSize',20);
set(0,'defaultLegendInterpreter','latex');
set(0,'defaultlinelinewidth',2);
set(0,'defaultTextInterpreter','latex');


%% 初期設定
dataname= 'data\1023_jirai_(15,15,3)';
dataHname = 'hosei(1-21GHz401points)_paralell';

[s,f] = data_load_py(dataname,dataHname);

%% kakk
s = s(:,:,[1 10:10:100]);
p = 0.1;

%% データの取り出しと補間

[s_sample,sample,sample_list] = data_sample(s,2);
s_use = data_fill(s_sample,sample_list);

%% データの取り出しと補間2
% 周波数方向に対してもランダムにサンプルをとる。
% [s_use,s_sample,sample,sample_list] = data_sample_all(s,1);

%% sからhを直接計算
r = 8;
t = 3;
model=make_model_sphere(r,t);
h=calc_h(s,model);
show_h(h);
exportgraphics(gcf,'figures/h_small.pdf')
put_model(h,model);
exportgraphics(gcf,'figures/hp_small.pdf')

%% 3次元面でhを表現
m = size(model,1);
l = 1;
gap = floor((m+l-2)/2);
h = circshift(h,[gap gap]);
figure;%surf(1:50,1:50,h);

%% 最適化
model=make_model_sphere(7,3);
[s_result,his,h_his,alpha_his,df_his]=gradient_descent(s_use,sample,model,p);
show_history_10_scaled(h_his,1,model);

