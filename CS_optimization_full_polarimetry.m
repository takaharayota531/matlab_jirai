clc;clear;close all;
set(0,'defaultfigurecolor',[1 1 1]);
set(0,'defaultAxesFontSize',20);
set(0,'defaultLegendInterpreter','latex');
set(0,'defaultlinelinewidth',2);
set(0,'defaultTextInterpreter','latex');

%% HV偏波プロット
%  dataFolder='data\new_measurement\';
%   HH_name='1031_right_left_(15,13,7)';
%   VV_name='1031_up_down_(15,13,7)';
%   HV_name='1103_right_up_(7,10,7)_400_300_3600';
%   VH_name='1103_down_left_(7,10,7)_400_300_3600';

%  dataFolder='data\new_measurement\1216\';
%   HH_name='HH_(12.5_2.5_5)_(60_58)';
%   VV_name='VV_(12.5_2.5_5)';
%   HV_name='HV_(12.5_2.5_5)_(60_58)';
%   VH_name='VH_(12.5_2.5_5)_(60_58)';
% 
%  data_hosei_HH_name='data\direct_coupling\HH_direct_coupling';
%  data_hosei_VH_name='data\direct_coupling\HV_direct_coupling';
%  data_hosei_HV_name='data\direct_coupling\VH_direct_coupling';
%  data_hosei_VV_name='data\direct_coupling\VV_direct_coupling';

 dataFolder='data1218\1219\';
  HH_name='HH_new';
  VV_name='VV_new';
  HV_name='HV_new';
  VH_name='VH_new';

 data_hosei_HH_name='data1218\direct_coupling\HH_new_direct_coupling';
 data_hosei_VH_name='data1218\direct_coupling\VH_new_direct_coupling';
 data_hosei_HV_name='data1218\direct_coupling\HV_new_direct_copling';
 data_hosei_VV_name='data1218\direct_coupling\VH_new_direct_coupling';
 

data_HH_name = append(dataFolder,HH_name);
data_VV_name = append(dataFolder,VV_name);
data_HV_name = append(dataFolder,HV_name);
data_VH_name = append(dataFolder,VH_name);
%dataHname = 'hosei(1-21GHz401points)_paralell';
%dataH_nanimonashi='data/0926_nanimonashi_ydirection';
% [s,f] = data_load_XY_raw(dataname);

%[s,f] = data_load_without_correction(dataname,dataHname);
%[s,f]=data_load_py_takahara(dataname,dataH_nanimonashi);
%% data_hosei
[s_HH,f_HH] = data_load_py_another(data_HH_name,data_hosei_HH_name);
[s_VV,f_VV] = data_load_py_another(data_VV_name,data_hosei_VV_name);
[s_HV,f_HV] = data_load_py_another(data_HV_name,data_hosei_HV_name);
[s_VH,f_VH] = data_load_py_another(data_VH_name,data_hosei_VH_name);
% [s_HH,f_HH] = data_load_py(data_HH_name,data_hosei_HH_name);
% [s_VV,f_VV] = data_load_py(data_VV_name,data_hosei_VV_name);
% [s_HV,f_HV] = data_load_py(data_HV_name,data_hosei_HV_name);
% [s_VH,f_VH] = data_load_py(data_VH_name,data_hosei_VH_name);


depth_start=0.26;
depth_end=0.36;
%depth=2.0;


%% HH_calc
depth_start=0;
depth_end=0.36;
p=0.1;

f=f_HH;%ここは要改善
%    s_HH_re=s_HH(8:53,8:53,:);
%    s_VV_re=s_VV(8:53,8:53,:);
%    s_HV_re=s_HV(15:end,15:end,:);
%    s_VH_re=s_VH(1:46,1:46,:);

%   SOME_MINUS=2;
  s_HH_re=s_HH(8:53,8:53,:);
  s_VV_re=s_VV(8:53,8:53,:);
  s_HV_re=s_HV(1:46,1:46,:);
  s_VH_re=s_VH(13:58,13:58,:);
%% plot
poincare_sphere_plot(s_HH_re,s_HV_re,s_VH_re,s_VV_re,f);%こっちが本来
%poincare_sphere_plot(s_HH_re,s_VH_re,s_HV_re,s_VV_re,f);



%% plot
HH_s_time_result1=migration_and_plot_polarization(s_HH_re,f, horzcat(HH_name,'_HH'),0.2,0.3);
%%
VV_s_time_result1=migration_and_plot_polarization(s_VV_re,f, horzcat(VV_name,'_VV'),0.2,0.3); 
%%
HV_s_time_result1 =migration_and_plot_polarization(s_HV_re,f, horzcat(HV_name,'_HV'),0.2,0.3);
%%
VH_s_time_result1 = migration_and_plot_polarization(s_VH_re,f, horzcat(VH_name,'_VH'),0.2,0.27);


%% s_HH_re=s_HH;
% HH_s_time_result=migration_and_plot_gaussianed(s_HH_re,f, horzcat(data_HH_name,'_HH'),depth_start,depth_end);
% VV_s_time_result=migration_and_plot_gaussianed(s_VV_re,f, horzcat(data_VV_name,'_VV'),depth_start,depth_end);
% HV_s_time_result =migration_and_plot_gaussianed(s_HV_re,f, horzcat(data_HV_name,'_HV'),depth_start,depth_end);
% VH_s_time_result = migration_and_plot_gaussianed(s_VH_re,f, horzcat(data_VH_name,'_VH'),depth_start,depth_end);




%% calc
% s = s_all(:,:,[1 10:10:100]);
% f=f_all([1 10:10:100]);
%p = 0.1;%評価関数のノルム
%migration_and_plot(s,f,dataname);
%% データの取り出しと補間

[s_sample,sample,sample_list] = data_sample(s_HV_re,2);
s_use = data_fill(s_sample,sample_list);

%% 試しにプロット
migration_and_plot_polarization(s_use,f, horzcat(HH_name,'_HH'),0,1);

%% モデル作成
p=0.1;
r=5;
t=5;
model=make_model_sphere(r,t);
%[r,t,model]=make_square_model(r,t);
%[r,t,model]=make_model_transpose(r,t,model);
%model=make_model_sphere(r,t);
%% 最適化
tic
[s_result,s_his,h_his,alpha_his,df_his]=gradient_descent(s_use,sample,model,p);
ans_tim=toc




%% 最適化後の結果表示

%migration_and_plot(s_result,f,dataname);
 h_most_count=show_history_10_scaled_takahara(h_his,1,model,r,t,'HV_result');
%% testplot
migration_and_plot(s_VV,f_VV,'VV_result');