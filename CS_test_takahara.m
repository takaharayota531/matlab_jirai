clc;clear;close all;
set(0,'defaultfigurecolor',[1 1 1]);
set(0,'defaultAxesFontSize',20);
set(0,'defaultLegendInterpreter','latex');
set(0,'defaultlinelinewidth',2);
set(0,'defaultTextInterpreter','latex');


%% 初期設定
dataname= 'data/0725_metalSphere_(20,20,2)';
dataHname = 'hosei(1-21GHz401points)_paralell';

[s,f] = data_load_py(dataname,dataHname);

%% kakk
s = s(:,:,[1 10:10:100]);
p = 0.1;

%% データの取り出しと補間

[s_sample,sample,sample_list] = data_sample(s,2);