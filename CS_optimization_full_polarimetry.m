clc;clear;close all;
set(0,'defaultfigurecolor',[1 1 1]);
set(0,'defaultAxesFontSize',20);
set(0,'defaultLegendInterpreter','latex');
set(0,'defaultlinelinewidth',2);
set(0,'defaultTextInterpreter','latex');

%% HV偏波プロット
%  dataFolder='data\new_measurement\';
%   HH_name='1031_right_left_15,13,7_change';
%   VV_name='1031_up_down_15,13,7_change';
%   HV_name='1103_right_up_7,10,7_400_300_3600_change';
%   VH_name='1103_down_left_7,10,7_400_300_3600_change';

%  dataFolder='data\new_measurement\1216\';
%  data_name_change='_change';
%   HH_name=append('HH_12.5_2.5_5_60_58',data_name_change);
%   VV_name=append('VV_12.5_2.5_5',data_name_change);
%   HV_name=append('HV_12.5_2.5_5_60_58',data_name_change);
%   VH_name=append('VH_12.5_2.5_5_60_58',data_name_change);
% 
%  data_hosei_HH_name='data\direct_coupling\HH_direct_coupling';
%  data_hosei_HV_name='data\direct_coupling\HV_direct_coupling';
%  data_hosei_VH_name='data\direct_coupling\VH_direct_coupling';
%  data_hosei_VV_name='data\direct_coupling\VV_direct_coupling';

%  dataFolder='data1218\1219\';
%   HH_name='HH_new';
%   VV_name='VV_new';
%   HV_name='HV_new';
%   VH_name='VH_new';


% dataFolder='data1218\0107\';
%   HH_name='HH_new';
%   VV_name='VV_new';
%   HV_name='HV_new';
%   VH_name='VH_new';

% dataFolder='data1218\0113_newsand\LR\';
% HH_name='HH_40_120';
% VV_name='VV';
% HV_name='HV_40_120';
% VH_name='VH_40_120';
  
% dataFolder='data1218\0116\';
%   HH_name='HH_60_120';
%   VV_name='VV_60_120';
%   HV_name='HV_60_120';
%   VH_name='VH_60_120';
  
  dataFolder='data1218\0117_45degree\';
  HH_name='HH_60_120';
  VV_name='VV_60_120';
  HV_name='HV_60_120';
  VH_name='VH_60_120_V_gyaku';

 



% dataHname ='data1218\direct0106\direct_VV';
% dataHname='data1218\0112\direct_9to19GHz\HH';

% dataFolder='data1218\0108\0108_ydirection\';
%   HH_name='HH_ydirection';
%   VV_name='VV_ydirection';
%   HV_name='HV_ydirection';
%   VH_name='VH_ydirection';

% dataFolder='data1218\0109_45degrees\';
%   HH_name='HH';
%   VV_name='VV';
%   HV_name='HV';
%   VH_name='VH';
% 
% 
% data_hosei_HH_name='data1218\0112\direct_9to19GHz\HH';
% data_hosei_VH_name='data1218\0112\direct_9to19GHz\VH';
% data_hosei_HV_name='data1218\0112\direct_9to19GHz\HV';
% data_hosei_VV_name='data1218\0112\direct_9to19GHz\VV';

% dataFolder='data1218\0107\';
%   HH_name='HH_new';
%   VV_name='VV_new';
%   HV_name='HV_new';
%   VH_name='VH_new';
% 
% 
%  data_hosei_HH_name='data1218\0108\direct_HH';
%  data_hosei_VH_name='data1218\0108\direct_VH';
%  data_hosei_HV_name='data1218\0108\direct_HV';
%  data_hosei_VV_name='data1218\direct0106\direct_VV';

% dataFolder='data1218\0119_5to15GHZ_45degree\';
% HH_name='HH_60_120';
% HV_name='HV_60_120';
% VH_name='VH_60_120';
% VV_name='VV_60_120';
% 
% dataFolder='data1218\0116\';
% HH_name='HH_60_120';
% HV_name='HV_60_120';
% VH_name='VH_60_120';
% VV_name='VV_60_120';



% dataFolder='data1218\0113_newsand\LR\';
% HH_name='HH_40_120';
% VV_name='VV';
% HV_name='HV_40_120';
% VH_name='VH_40_120';

% data_hosei_HH_name='data1218\0124_5to15GHz_direct_coupling\HH_direct';
% data_hosei_VH_name='data1218\0124_5to15GHz_direct_coupling\VH_direct';
% data_hosei_HV_name='data1218\0124_5to15GHz_direct_coupling\HV_direct';
% data_hosei_VV_name='data1218\0124_5to15GHz_direct_coupling\VV_direct';


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
IF_DIFF=true;
[s_HH,f_HH] = data_load_py_another(data_HH_name,data_hosei_HH_name,IF_DIFF);
[s_VV,f_VV] = data_load_py_another(data_VV_name,data_hosei_VV_name,IF_DIFF);
[s_HV,f_HV] = data_load_py_another(data_HV_name,data_hosei_HV_name,IF_DIFF);
[s_VH,f_VH] = data_load_py_another(data_VH_name,data_hosei_VH_name,IF_DIFF);
% [s_HH,f_HH] = data_load_py(data_HH_name,data_hosei_HH_name);
% [s_VV,f_VV] = data_load_py(data_VV_name,data_hosei_VV_name);
% [s_HV,f_HV] = data_load_py(data_HV_name,data_hosei_HV_name);
% [s_VH,f_VH] = data_load_py(data_VH_name,data_hosei_VH_name);




%% HH_calc

p=0.1;

f=f_HH;%ここは要改善




% s_HH_re=s_HH(8:53,8:53,:);
% s_VV_re=s_VV(8:53,8:53,:);
% s_HV_re=s_HV(15:end,15:end,:);
% s_VH_re=s_VH(1:46,1:46,:);   


%    s_HH_re=s_HH(8:51,8:51,:);
%    s_VV_re=s_VV(8:51,8:51,:);
%    s_HV_re=s_HV(15:58,15:58,:);
%    s_VH_re=s_VH(1:44,1:44,:);

% 
% s_HH_re=s_HH;
% s_VV_re=s_VV;
% s_HV_re=s_HV;
% s_VH_re=s_VH;

%   s_HH_re=s_HH;
%   s_VV_re=s_VV;
%   s_HV_re=s_HV;
%   s_VH_re=s_VH;
% % 
%   s_HH_re=s_HH(8:51,8:51,:);
%   s_VV_re=s_VV(8:51,8:51,:);
%   s_HV_re=s_HV(1:44,1:44,:);
%   s_VH_re=s_VH(15:58,15:58,:);

% CUT_SIZE =7;
% CUT_SIZE_RE=0;
  s_HH_re=s_HH(CUT_SIZE+1:end-CUT_SIZE,CUT_SIZE+1:end-CUT_SIZE-CUT_SIZE_RE,:);
  s_VV_re=s_VV(CUT_SIZE+1:end-CUT_SIZE,CUT_SIZE+1:end-CUT_SIZE,:);
  s_HV_re=s_HV(1:end-CUT_SIZE*2,1:end-CUT_SIZE*2-CUT_SIZE_RE,:);
  s_VH_re=s_VH(1+CUT_SIZE*2:end,1+CUT_SIZE*2:end-CUT_SIZE_RE,:);


%45度用のやつ
% CUT_SIZE =7;
% CUT_SIZE_RE=0;
%   s_HH_re=s_HH(CUT_SIZE+1:end-CUT_SIZE,CUT_SIZE+1:end-CUT_SIZE,:);
%   s_VV_re=s_VV(CUT_SIZE+1:end-CUT_SIZE,CUT_SIZE+1:end-CUT_SIZE,:);
%   s_HV_re=s_HV(1:end-CUT_SIZE*2,1:end-CUT_SIZE*2,:);
%   s_VH_re=s_VH(1:end-CUT_SIZE*2,1+CUT_SIZE*2:end,:);
%% 定数値 
window_size=7;
FREQ_POINT=201;
IF_PLOT=true
IF_RANGE=false;
depth_start=0.2;
depth_end=0.3;
X_SIZE=size(s_HH_re,1);
Y_SIZE=size(s_HH_re,2);
Z_SIZE=size(s_HH_re,3);
%% plot

[HH_s_time_result1,index_distance]=migration_and_plot_polarization_full_polarimetry(s_HH_re,f, horzcat(HH_name,'_HH'),depth_start,depth_end,IF_RANGE,IF_PLOT);
[VV_s_time_result1,~]=migration_and_plot_polarization_full_polarimetry(s_VV_re,f, horzcat(VV_name,'_VV'),depth_start,depth_end,IF_RANGE,IF_PLOT); 
[HV_s_time_result1 ,~]=migration_and_plot_polarization_full_polarimetry(s_HV_re,f, horzcat(HV_name,'_HV'),depth_start,depth_end,IF_RANGE,IF_PLOT);
[VH_s_time_result1 ,~]= migration_and_plot_polarization_full_polarimetry(s_VH_re,f, horzcat(VH_name,'_VH'),depth_start,depth_end,IF_RANGE,IF_PLOT);

 %% plot
%  [x_hori_re,y_hori_re,z_hori_re,...
%     x_ver_re,y_ver_re,z_ver_re,...
%     x_for_45_re,y_for_45_re,z_for_45_re,... 
%     x_back_45_re,y_back_45_re,z_back_45_re,... 
%     x_left_45_re,y_left_45_re,z_left_45_re,...
%     x_right_45_re,y_right_45_re,z_right_45_re]=poincare_sphere_plot(s_HH_re,s_HV_re,s_VH_re,s_VV_re,f,window_size);%こっちが本来

%       poincare_sphere_arrange(s_HH_re,s_HV_re,s_VH_re,s_VV_re,f,window_size);
% 
% target_point=201; 
% poincare_sphere_data_management(s_HH_re,s_HV_re,s_VH_re,s_VV_re,f,window_size,target_point);

%% time domain

   
    [x_hori_re,y_hori_re,z_hori_re,...
    x_ver_re,y_ver_re,z_ver_re,...
    x_for_45_re,y_for_45_re,z_for_45_re,... 
    x_back_45_re,y_back_45_re,z_back_45_re,... 
    x_left_45_re,y_left_45_re,z_left_45_re,...
    x_right_45_re,y_right_45_re,z_right_45_re]=poincare_sphere_plot(HH_s_time_result1,HV_s_time_result1,VH_s_time_result1,VV_s_time_result1,f,window_size,index_distance);

%    poincare_sphere_arrange(HH_s_time_result1,HV_s_time_result1,VH_s_time_result1,VV_s_time_result1,f,window_size);

% target_point=201; 
% poincare_sphere_data_management(HH_s_time_result1,HV_s_time_result1,VH_s_time_result1,VV_s_time_result1,f,window_size,target_point);

%% nearst stokes point
ans_array=find_nearest_stokes_point(x_hori_re,y_hori_re,z_hori_re);
%% plot


depth_start=0;
depth_end=1;

% HH_s_time_result1=migration_and_plot_polarization(s_HH_re,f, horzcat(HH_name,'_HH'),depth_start,depth_end);
% VV_s_time_result1=migration_and_plot_polarization(s_VV_re,f, horzcat(VV_name,'_VV'),depth_start,depth_end); 
% HV_s_time_result1 =migration_and_plot_polarization(s_HV_re,f, horzcat(HV_name,'_HV'),depth_start,depth_end);
% VH_s_time_result1 = migration_and_plot_polarization(s_VH_re,f, horzcat(VH_name,'_VH'),depth_start,depth_end);
%% plot

%  [x_hori_re_time,y_hori_re_time,z_hori_re_time,...
%     x_ver_re_time,y_ver_re_time,z_ver_re_time,...
%     x_for_45_re_time,y_for_45_re_time,z_for_45_re_time,... 
%     x_back_45_re_time,y_back_45_re_time,z_back_45_re_time,... 
%     x_left_45_re_time,y_left_45_re_time,z_left_45_re_time,...
%     x_right_45_re_time,y_right_45_re_time,z_right_45_re_time]=poincare_sphere_plot(HH_s_time_result1 , HV_s_time_result1 , VH_s_time_result1 , VV_s_time_result1 ,f,window_size);


%% input data create
input_data_xyz_array=input_feature_matrix(x_hori_re,y_hori_re,z_hori_re,...
    x_ver_re,y_ver_re,z_ver_re,...
    x_for_45_re,y_for_45_re,z_for_45_re,... 
    x_back_45_re,y_back_45_re,z_back_45_re,... 
    x_left_45_re,y_left_45_re,z_left_45_re,...
    x_right_45_re,y_right_45_re,z_right_45_re);


size(input_data_xyz_array)

%% input actual data

% input_data_array=decide_window(data_size_change(cat(3,s_HH_re,s_HV_re,s_VH_re,s_VV_re),window_size),window_size);
input_feature_array=decide_window(data_size_change(cat(3,HH_s_time_result1,HV_s_time_result1,VH_s_time_result1,VV_s_time_result1),window_size),window_size);



%% DOP  DOPを入力特徴量とする
% hori_dop=calc_DOP(x_hori_re,y_hori_re,z_hori_re);
% ver_dop=calc_DOP(x_ver_re,y_ver_re,z_ver_re);
% add_45_dop=calc_DOP(x_for_45_re,y_for_45_re,z_for_45_re);
% sub_45_dop=calc_DOP(x_back_45_re,y_back_45_re,z_back_45_re);
% left_dop=calc_DOP(x_left_45_re,y_left_45_re,z_left_45_re);
% right_dop=calc_DOP( x_right_45_re,y_right_45_re,z_right_45_re);
% input_dop_feature_array=cat(3,hori_dop,ver_dop,add_45_dop,sub_45_dop,left_dop,right_dop);

%% reflect calc dop
% ans_array_dop=dop_2_pipe_direction(hori_dop,ver_dop,add_45_dop,sub_45_dop,left_dop,right_dop, ...
%     x_hori_re,x_ver_re,x_for_45_re,x_back_45_re,x_left_45_re,x_right_45_re, ...
%     X_SIZE,Y_SIZE,Z_SIZE);
% 
% % imagesc(ans_array)
% depth_start=0.2;
% depth_end=0.45;
% migration_and_plot_polarization(ans_array_dop,f, horzcat('','ans_array_plot'),depth_start,depth_end);

%% calc
% s = s_all(:,:,[1 10:10:100]);
% f=f_all([1 10:10:100]);
%p = 0.1;%評価関数のノルム
%migration_and_plot(s,f,dataname);
%% データの取り出しと補間

% lambda=0.5;

% input_feature_array=cat(3,input_data_array*(1-lambda),input_dop_feature_array*lambda);

[s_sample,sample,sample_list] = data_sample(input_feature_array,2);
% [s_sample,sample,sample_list] = data_sample(input_feature_array,2);


% [s_sample,sample,sample_list] = data_sample(s_HH,2);

s_use = data_fill(s_sample,sample_list);

%% 試しにプロット
%migration_and_plot_polarization(s_use,cat(3,f,f,f,f,f,f,f), horzcat('try','window=7'),0,1);

%% モデル作成
p=0.1;
r=1;
t=1;
% model=make_model_sphere(r,t);
 [r,t,model]=make_square_model(r,t);
% [r,t,model]=make_model_transpose(r,t,model);
%model=make_model_sphere(r,t);
%% 最適化
% tic
% [s_result,s_his,h_his,alpha_his,df_his]=gradient_descent(s_use,sample,model,p);
% ans_tim=toc

WHEN="0124";

experiment_content=  "通常のgradient_descent_window="+window_size+",r="+r+",t="+t
IF_RANGE
window_size
tic
[s_result,s_his,h_his,alpha_his,df_his]=gradient_descent(s_use,sample,model,p);
% ans_tim=toc
ans_tim=toc



%% alpha plot

plot(alpha_his)
title('アルミホの条件のalpha')
xlabel('試行回数')
ylabel('alpha')
%% 最適化後の結果表示
 h_most_count=show_history_10_scaled_takahara(h_his,1,model,r,t,'通常のdata1218\0116\gradient_descent_パイプモデル',0);
%migration_and_plot(s_result,f,dataname);
%  h_most_count=show_history_10_scaled_takahara(h_his,1,model,r,t,'0112_lambda=0.5_windows=7_横モデル_ydirection');
%% testplot
migration_and_plot(s_VV,f_VV,'VV_result');