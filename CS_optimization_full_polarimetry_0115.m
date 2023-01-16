clc;clear;close all;
set(0,'defaultfigurecolor',[1 1 1]);
set(0,'defaultAxesFontSize',20);
set(0,'defaultLegendInterpreter','latex');
set(0,'defaultlinelinewidth',2);
set(0,'defaultTextInterpreter','latex');


%% HV偏波プロット
% dataFolder='data1218\0113_newsand\LR\';
% HH_name='HH_40_120';
% VV_name='VV';
% HV_name='HV_40_120';
% VH_name='VH_40_120';

dataFolder='data1218\0107\';
  HH_name='HH_new';
  VV_name='VV_new';
  HV_name='HV_new';
  VH_name='VH_new';


 data_hosei_HH_name='data1218\0108\direct_HH';
 data_hosei_VH_name='data1218\0108\direct_VH';
 data_hosei_HV_name='data1218\0108\direct_HV';
 data_hosei_VV_name='data1218\direct0106\direct_VV';

% data_hosei_HH_name='data1218\0112\direct_9to19GHz\HH';
% data_hosei_VH_name='data1218\0112\direct_9to19GHz\VH';
% data_hosei_HV_name='data1218\0112\direct_9to19GHz\HV';
% data_hosei_VV_name='data1218\0112\direct_9to19GHz\VV';

data_HH_name = append(dataFolder,HH_name);
data_VV_name = append(dataFolder,VV_name);
data_HV_name = append(dataFolder,HV_name);
data_VH_name = append(dataFolder,VH_name);

%% data_hosei
IF_DIFF=true;
[s_HH,f_HH] = data_load_py_another(data_HH_name,data_hosei_HH_name,IF_DIFF);
[s_VV,f_VV] = data_load_py_another(data_VV_name,data_hosei_VV_name,IF_DIFF);
[s_HV,f_HV] = data_load_py_another(data_HV_name,data_hosei_HV_name,IF_DIFF);
[s_VH,f_VH] = data_load_py_another(data_VH_name,data_hosei_VH_name,IF_DIFF);



%% HH_calc

p=0.1;
f=f_HH;%ここは要改善

%   s_HH_re=s_HH;
%   s_VV_re=s_VV;
%   s_HV_re=s_HV;
%   s_VH_re=s_VH;

  s_HH_re=s_HH(8:51,8:51,:);
  s_VV_re=s_VV(8:51,8:51,:);
  s_HV_re=s_HV(1:44,1:44,:);
  s_VH_re=s_VH(15:58,15:58,:);

CUT_SIZE =7;
CUT_SIZE_RE=20;
% s_HH_re=s_HH(CUT_SIZE+1:end-CUT_SIZE,CUT_SIZE+1:end-CUT_SIZE-CUT_SIZE_RE,:);
% s_VV_re=s_VV(CUT_SIZE+1:end-CUT_SIZE,CUT_SIZE+1:end-CUT_SIZE,:);
% s_HV_re=s_HV(1:end-CUT_SIZE*2,1:end-CUT_SIZE*2-CUT_SIZE_RE,:);
% s_VH_re=s_VH(1+CUT_SIZE*2:end,1+CUT_SIZE*2:end-CUT_SIZE_RE,:);
%% 定数値 
window_size=7;
depth_start=0.26;
depth_end=0.4;
X_SIZE=size(s_HH_re,1);
Y_SIZE=size(s_HH_re,2);
Z_SIZE=size(s_HH_re,3);

%% input actual data
input_data_array=decide_window(data_size_change(cat(3,s_HH_re,s_HV_re,s_VH_re,s_VV_re),window_size),window_size);

%% データの取り出しと補間

[s_sample,sample,sample_list] = data_sample(input_data_array,2);

s_use = data_fill(s_sample,sample_list);

%% 試しにプロット
%migration_and_plot_polarization(s_use,cat(3,f,f,f,f,f,f,f), horzcat('try','window=7'),0,1);

%% モデル作成
p=0.1;
r=2;
t=1;
FREQ_POINT=201;
Z_NUM=7;
% model=make_model_sphere(r,t);
 [r,t,model]=make_square_model(r,t);
% [r,t,model]=make_model_transpose(r,t,model);
%model=make_model_sphere(r,t);
%% 最適化
tic
[s,s_his,h_his,alpha_his,df_his]=gradient_descent_full_polarimetry(s_use,sample,model,p,FREQ_POINT,Z_NUM);
ans_tim=toc





%% 最適化後の結果表示

%migration_and_plot(s_result,f,dataname);
 h_most_count=show_history_10_scaled_takahara(h_his,1,model,r,t,'0112_lambda=0.5_windows=7_横モデル_ydirection');
%% testplot
migration_and_plot(s_VV,f_VV,'VV_result');