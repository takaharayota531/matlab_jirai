clc;clear;close all;
set(0,'defaultfigurecolor',[1 1 1]);
set(0,'defaultAxesFontSize',20);
set(0,'defaultLegendInterpreter','latex');
set(0,'defaultlinelinewidth',2);
set(0,'defaultTextInterpreter','latex');

%% 初期設定
dataname= 'data/0918_metalpipe_15_0_8';
dataHname = 'hosei(1-21GHz401points)_paralell';

[s_all,f_all] = data_load_py(dataname,dataHname);

%% 試しにプロット
depth=0.4;
%migration_and_plot(s,f,dataname,depth);

%% calc
s = s_all(:,:,[1 10:10:100]);
f=f_all([1 10:10:100]);
p = 0.1;%評価関数のノルム
%migration_and_plot(s,f,dataname);
%% データの取り出しと補間

[s_sample,sample,sample_list] = data_sample(s,2);
s_use = data_fill(s_sample,sample_list);

%% 試しにプロット
%migration_and_plot(s_use,f,dataname,depth);

%% モデル作成
p=0.1;
r=5;
t=5;
model=make_model_sphere(7,3);
 [r,t,model]=make_square_model_pipe(r,t);
 [r,t,model]=make_model_transpose(r,t,model);
%model=make_model_sphere(r,t);
%% 最適化
tic
[s_result,s_his,h_his,alpha_his,df_his]=gradient_descent_takahara(s_use,sample,model,p);
ans_tim=toc


%% 最適化後の結果表示

%migration_and_plot(s_result,f,dataname);
show_history_10_scaled_takahara(h_his,1,model,r,t,'square_pipeモデル横実行時間183秒');



%% ランダムサンプリングを何回か繰り返し、サンプル座標による最適化結果の変化を調べる
clear;clc;close all force;

dataname='data/0918_metalpipe_15_0_8';
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