clc; clear; close all;
set(0, 'defaultfigurecolor', [1 1 1]);
set(0, 'defaultAxesFontSize', 20);
set(0, 'defaultLegendInterpreter', 'latex');
set(0, 'defaultlinelinewidth', 2);
set(0, 'defaultTextInterpreter', 'latex');

%% HV偏波プロット
dataFolder = 'data\new_measurement\';
HH_name = '1113\1113_45degree_right__left_(435,335)_1200';
VV_name = '1113\1113_45degree_down_up_(435,335)_1200';
HV_name = '1113\1113_45degree_right_up_(470,370)_1200';
VH_name = '1113\1113_45degree_down_left_(400,300)_1200';
data_HH_name = append(dataFolder, HH_name);
data_VV_name = append(dataFolder, VV_name);
data_HV_name = append(dataFolder, HV_name);
data_VH_name = append(dataFolder, VH_name);
dataHname = 'hosei(1-21GHz401points)_paralell';
%dataH_nanimonashi='data/0926_nanimonashi_ydirection';
% [s,f] = data_load_XY_raw(dataname);

%[s,f] = data_load_without_correction(dataname,dataHname);
%[s,f]=data_load_py_takahara(dataname,dataH_nanimonashi);
[s_HH, f_HH] = data_load_py(data_HH_name, dataHname);
[s_VV, f_VV] = data_load_py(data_VV_name, dataHname);
[s_HV, f_HV] = data_load_py(data_HV_name, dataHname);
[s_VH, f_VH] = data_load_py(data_VH_name, dataHname);

%depth=2.0;

%% HH_calc
p = 0.1;
f = f_HH([1 10:10:100]); %ここは要改善
s_HH_re = s_HH(:,:, [1 10:10:100]);
s_VV_re = s_VV(:,:, [1 10:10:100]);
s_HV_re = s_HV(:,:, [1 10:10:100]);
s_VH_re = s_VH(:,:, [1 10:10:100]);
%% length
depth_start = 0.27;
depth_end = 0.45;
%% HH plot
HH_s_time_result=migration_and_plot_gaussianed(s_HH,f_HH, horzcat(data_HH_name,'_HH'),depth_start,depth_end);
%% VV plot
VV_s_time_result=migration_and_plot_gaussianed(s_VV,f_VV, horzcat(data_VV_name,'_VV'),depth_start,depth_end);
%% HV plot
HV_s_time_result =migration_and_plot_gaussianed(s_HV,f_HV, horzcat(data_HV_name,'_HV'),depth_start,depth_end);
%% VH plot
VH_s_time_result = migration_and_plot_gaussianed(s_VH,f_VH, horzcat(data_VH_name,'_VH'),depth_start,depth_end);

% HH_s_time_result = migration_and_plot_polarization(s_HH_re, f, horzcat(data_HH_name, '_HH'), depth_start, depth_end);
% VV_s_time_result = migration_and_plot_polarization(s_VV_re, f, horzcat(data_VV_name, '_VV'), depth_start, depth_end);
% HV_s_time_result = migration_and_plot_polarization(s_HV_re, f, horzcat(data_HV_name, '_HV'), depth_start, depth_end);
% VH_s_time_result = migration_and_plot_polarization(s_VH_re, f, horzcat(data_VH_name, '_VH'), depth_start, depth_end);

%% calc
% s = s_all(:,:,[1 10:10:100]);
% f=f_all([1 10:10:100]);
%p = 0.1;%評価関数のノルム
%migration_and_plot(s,f,dataname);
%% データの取り出しと補間

[s_sample, sample, sample_list] = data_sample(s_VV_re, 2);
s_use = data_fill(s_sample, sample_list);

%% 試しにプロット
%migration_and_plot(s_use,f,dataname,depth);

%% モデル作成
p = 0.1;
r = 5;
t = 5;
%model=make_model_sphere(7,3);
[r, t, model] = make_square_model(r, t);
%[r,t,model]=make_model_transpose(r,t,model);
%model=make_model_sphere(r,t);
%% 最適化
tic
[s_result, s_his, h_his, alpha_his, df_his] = gradient_descent(s_use, sample, model, p);
ans_tim = toc

%% 最適化後の結果表示

%migration_and_plot(s_result,f,dataname);
show_history_10_scaled_takahara(h_his, 1, model, r, t, 'VV_result');
%% testplot
migration_and_plot(s_VV, f_VV, 'VV_result');
