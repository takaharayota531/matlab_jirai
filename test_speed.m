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
dataFolder='data1218\0116\';
HH_name='HH_60_120';
HV_name='HV_60_120';
VH_name='VH_60_120';
VV_name='VV_60_120';


data_hosei_HH_name='data1218\0112\direct_9to19GHz\HH';
data_hosei_VH_name='data1218\0112\direct_9to19GHz\VH';
data_hosei_HV_name='data1218\0112\direct_9to19GHz\HV';
data_hosei_VV_name='data1218\0112\direct_9to19GHz\VV';

% dataFolder='data1218\0119_5to15GHZ_45degree\';
% HH_name='HH_60_120';
% HV_name='HV_60_120';
% VH_name='VH_60_120';
% VV_name='VV_60_120';


% data_hosei_HH_name='data1218\0124_5to15GHz_direct_coupling\HH_direct';
% data_hosei_VH_name='data1218\0124_5to15GHz_direct_coupling\VH_direct';
% data_hosei_HV_name='data1218\0124_5to15GHz_direct_coupling\HV_direct';
% data_hosei_VV_name='data1218\0124_5to15GHz_direct_coupling\VV_direct';


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
% 
%   s_HH_re=s_HH(8:51,8:51,:);
%   s_VV_re=s_VV(8:51,8:51,:);
%   s_HV_re=s_HV(1:44,1:44,:);
%   s_VH_re=s_VH(15:58,15:58,:);

CUT_SIZE =7;
CUT_SIZE_RE=0;
% CUT_SIZE_RE=20;
s_HH_re=s_HH(CUT_SIZE+1:end-CUT_SIZE,CUT_SIZE+1:end-CUT_SIZE-CUT_SIZE_RE,:);
s_VV_re=s_VV(CUT_SIZE+1:end-CUT_SIZE,CUT_SIZE+1:end-CUT_SIZE,:);
s_HV_re=s_HV(1:end-CUT_SIZE*2,1:end-CUT_SIZE*2-CUT_SIZE_RE,:);
s_VH_re=s_VH(1+CUT_SIZE*2:end,1+CUT_SIZE*2:end-CUT_SIZE_RE,:);
%% 定数値 
window_size=2
IF_RANGE=true
depth_start=0.25;
depth_end=0.3;
X_SIZE=size(s_HH_re,1);
Y_SIZE=size(s_HH_re,2);
Z_SIZE=size(s_HH_re,3);
% FREQ_POINT=201;

%% plot
IF_PLOT=false
[HH_s_time_result1,index_distance]=migration_and_plot_polarization_full_polarimetry(s_HH_re,f, horzcat(HH_name,'_{HH}'),depth_start,depth_end,IF_RANGE,IF_PLOT);
[VV_s_time_result1,~]=migration_and_plot_polarization_full_polarimetry(s_VV_re,f, horzcat(VV_name,'_{VV}'),depth_start,depth_end,IF_RANGE,IF_PLOT); 
[HV_s_time_result1 ,~]=migration_and_plot_polarization_full_polarimetry(s_HV_re,f, horzcat(HV_name,'_{HV}'),depth_start,depth_end,IF_RANGE,IF_PLOT);
[VH_s_time_result1 ,~]= migration_and_plot_polarization_full_polarimetry(s_VH_re,f, horzcat(VH_name,'_{VH}'),depth_start,depth_end,IF_RANGE,IF_PLOT);
%%
[x_hori_re,y_hori_re,z_hori_re,...
x_ver_re,y_ver_re,z_ver_re,...
x_for_45_re,y_for_45_re,z_for_45_re,... 
x_back_45_re,y_back_45_re,z_back_45_re,... 
x_left_45_re,y_left_45_re,z_left_45_re,...
x_right_45_re,y_right_45_re,z_right_45_re]=poincare_sphere_plot(HH_s_time_result1,HV_s_time_result1,VH_s_time_result1,VV_s_time_result1,f,window_size,index_distance);

%% input actual data
% pre_input_data_array= 
% input_data_array= decide_window(data_size_change(cat(3,s_HH_re,s_HV_re,s_VH_re,s_VV_re),window_size),window_size);
input_data_array=decide_window(data_size_change(cat(3,HH_s_time_result1,HV_s_time_result1,VH_s_time_result1,VV_s_time_result1),window_size),window_size);
%% find_nearestの改訂版を作成する
% [ans_array_S_HH,ans_array_S_HV,ans_array_S_VH,ans_array_S_VV] = find_nearest_stokes_vector_full_polarimetry(input_data_array,FREQ_POINT,false,4);

%% データの取り出しと補間

[s_sample,sample,sample_list] = data_sample(input_data_array,2);

s_use = data_fill(s_sample,sample_list);
% s_use = s_use(:,:,[1 10:20:770]);
% f=f([1 10:10:100]);
%% 試しにプロット
%migration_and_plot_polarization(s_use,cat(3,f,f,f,f,f,f,f), horzcat('try','window=7'),0,1);

%% モデル作成

r=5;
t=2;

FREQ_POINT=size(input_data_array,3)/4;
Z_NUM=7;
% model=make_model_sphere(r,t);
%  [r,t,model]=make_square_model(r,t);
% [r,t,model]=make_model_transpose(r,t,model);
%model=make_model_sphere(r,t);
[r,t,model]=make_square_model_without_diretion(r,t);
%% 普通の圧縮センシング
% tic
% [s_result,s_his,h_his,alpha_his,df_his]=gradient_descent(s_use,sample,model,p);
% ans_tim=toc
% %% alpha plot

% plot(alpha_his)
% title('アルミホの条件のalpha')
% xlabel('試行回数')
% ylabel('alpha')
% %% nan
%  h_most_count0=show_history_10_scaled_takahara(h_his,1,model,r,t,'data1218\0116\gradient_descent',0);
%% 最適化
%  E_iH=1/sqrt(2);
%  E_iV=1/sqrt(2);
% E_iH=0;
% E_iV=1;
% p=0.1
% WHEN="0116"
lambda=0.7
alpha_size=5*10^-4
% experiment_content=  "gradient_descent_window="+window_size+",r="+r+",t="+t+",lambda="+lambda
experiment_content=  "hill_climbing_method_test_speed="+window_size+",r="+r+",t="+t;
IF_RANGE
window_size
%% execution
tic
%     [s,s_his,h_his,alpha_his,df_his,f_list]  =gradient_descent(input_data_array, model, p);
% [s_list,h_list,f_list,K_list]=mountain_climbing_method_re(input_data_array,model,p,alpha_size);
  [s_list,h_list,f_list]=atodekesu_re(input_data_array,model,p,alpha_size);
% [s,s_his,h_his,alpha_his,df_his,K_list,f_list]=gradient_descent_full_polarimetry(input_data_array,model,p,FREQ_POINT,Z_NUM,E_iH,E_iV,WHEN,lambda);
ans_tim=toc
%% hlist
% 
% target_point=1;
% % target_point=10;
% s_his_re=s_his(:,:,:,target_point);
% 
% df1=df_his(:,:,:,1,target_point);
% df2=df_his(:,:,:,2,target_point);
% f_his_re=f_list(target_point);
% c=10e-3
% d=-10:0.1:30;
% % df_degree=zeros(size(df_his_re));
% % df_degree(1,1,end)=1;
% % df_change=f_his_re+d*squeeze(df1(1,1,1).*df_degree(1,1,1));
% df_degree=ones(size(df1));
% df_change=f_his_re+d*squeeze(sum(df1.*df_degree,'all')+sum(df2.*conj(df_degree),'all'))*c;
% % df_change=f_his_re+d*squeeze(sum(df1.*df_degree,'all'));
% f_function=[];
% for e=-10:0.1:30
%     f_function(end+1)=calc_f_gradient_descent(s_his_re+e*df_degree,model,p);
% end
% figure(2);
% plot(d,df_change,'r')
% hold on
% plot(d,f_function,'b')
% hold off
% legend('傾き','評価関数');
% % plot(d,df_change,'b',d,f_function,'r')
%% plot
figure(3)
plot(f_list(:,1))
title(['評価関数'])
xlabel('試行回数')
ylabel('f')
%% 
figure(4);
plot(alpha_his)
title('アルミホの条件のalpha通常')
xlabel('試行回数')
ylabel('alpha')


%% 最適化後の結果表示

input_string=horzcat(dataFolder,experiment_content,"")
 h_most_count=show_history_10_scaled_takahara(h_list(:,:,1:6),1,model,r,t,input_string,0);

 h_most_count=show_history_10_scaled_takahara(h_list(:,:,7:end),1,model,r,t,input_string,6);
%% testplot
% migration_and_plot(s_VV,f_VV,'VV_result');

s1=s_list(:,:,:,1);
s6=s_list(:,:,:,2);