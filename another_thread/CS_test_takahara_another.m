clc;clear;close all;
set(0,'defaultfigurecolor',[1 1 1]);
set(0,'defaultAxesFontSize',20);
set(0,'defaultLegendInterpreter','latex');
set(0,'defaultlinelinewidth',2);
set(0,'defaultTextInterpreter','latex');


%% 初期設定
dataPath="C:\Users\takahara yota\Documents\matlab_files_takahara\";
dataname= 'data\new_measurement\1031_right_left_(15,13,7)';
dataHname = 'hosei(1-21GHz401points)_paralell';

[s,f] = data_load_py(dataname,dataHname);
%% 試しにプロット
%depth=0.4;


%% kakk
s = s(:,:,[1 10:10:100]);
f=f([1 10:10:100]);
p = 0.1;%評価関数のノルム

 %% データの取り出しと補間

[s_sample,sample,sample_list] = data_sample(s,2);
 s_use = data_fill(s_sample,sample_list);

% %% 試しにプロット
% migration_and_plot(s_use,f,dataname,depth);
% %% データの取り出しと補間2
% % 周波数方向に対してもランダムにサンプルをとる。
% % [s_use,s_sample,sample,sample_list] = data_sample_all(s,1);

% %% sからhを直接計算
% r = 8;
% t = 3;
% model=make_model_sphere(r,t);
% h=calc_h(s,model);
% show_h(h);
% exportgraphics(gcf,'figures/h_small.pdf')
% put_model(h,model);
% exportgraphics(gcf,'figures/hp_small.pdf')

%


%% モデル作成
r=7;t=3;
model=make_model_sphere(r,t);
%% 最適化
[s_result,s_his,h_his,alpha_his,df_his]=gradient_descent(s_use,sample,model,p);



%% 最適化後の結果表示

migration_and_plot(s_result,f,dataname);
show_history_10_scaled_takahara(h_his,1,model,r,t);
%% ランダムサンプリングを何回か繰り返し、サンプル座標による最適化結果の変化を調べる
clear;clc;close all force;

dataname='data\1023_jirai_(15,15,3)';
dataHname='hosei(1-21GHz401points)_paralell';

s=data_load_py(dataname,dataHname);

p=0.1;
n=10;%繰り返し回数
r=8;%モデルの半径
t=3;%モデル外側の厚み
rate=2;%データサンプルの割合

model=make_model_sphere(r,t);

for i=1:100
    [s_sample,sample,sample_list]=data_sample(s,rate);
    s_use=data_fill(s_sample,sample_list);

    [s_result,his,h_his,alpha_his,df_his]=gradient_descent(s_use,sample,model,p);
    filename = horzcat('result/', dataname, '/1_', num2str(rate), '%/result', num2str(i));
    save(filename);
end