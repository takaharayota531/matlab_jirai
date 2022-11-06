% migration x,y,fからx,y,zに変換周波数領域→時間領域に変換して位置に変換
%clc:すべてのテキストをクリア
%clear ワークスペースからアイテムを削除
%close figureを閉じる
clc; clear; close all;
set(0,'defaultfigurecolor',[1 1 1]);
set(0,'defaultAxesFontSize',20);
set(0,'defaultLegendInterpreter','latex');
set(0,'defaultlinelinewidth',2);
set(0,'defaultTextInterpreter','latex');
%% plot
% load measured data
dataFolder='data\new_measurement\';

%dataFile='0918_metalpipe_15_0_8';
HH_name='1031_right_left_(15,13,7)';
VV_name='1031_up_down_(15,13,7)';
HV_name='1103_right_up_(7,10,7)_400_300_3600';
VH_name='1103_down_left_(7,10,7)_400_300_3600';
data_HH_name = append(dataFolder,HH_name);
data_VV_name = append(dataFolder,VV_name);
data_HV_name = append(dataFolder,HV_name);
data_VH_name = append(dataFolder,VH_name);
dataHname = 'hosei(1-21GHz401points)_paralell';
dataH_nanimonashi='data/0926_nanimonashi_ydirection';
% [s,f] = data_load_XY_raw(dataname);

%[s,f] = data_load_without_correction(dataname,dataHname);
%[s,f]=data_load_py_takahara(dataname,dataH_nanimonashi);
[s_HH,f_HH] = data_load_py(data_HH_name,dataHname);
[s_VV,f_VV] = data_load_py(data_VV_name,dataHname);
[s_HV,f_HV] = data_load_py(data_HV_name,dataHname);
[s_VH,f_VH] = data_load_py(data_VH_name,dataHname);
depth=0.36;
%depth=2.0;


migration_and_plot_polarization(s_HH,f_HH, horzcat(data_HH_name,'_HH'),depth);
%% 
migration_and_plot_polarization(s_VV,f_VV, horzcat(data_VV_name,'_VV'),depth);
migration_and_plot_polarization(s_HV,f_HV, horzcat(data_HV_name,'_HV'),depth);
migration_and_plot_polarization(s_VH,f_HH, horzcat(data_VH_name,'_VH'),depth);


%% 位相復元

PR = phase_retrieval(s_time,0.05,Nfft,l,index_distance,index_frequency);

%% 復元結果表示
K = PR;
phase_rot = reshape(l(index_distance)-0.2,1,1,[])/nu.*reshape(f,1,1,1,[])*2*pi;
K = PR.*exp(-1i*phase_rot);
% K = ones(size(PR_mig)).*exp(-1i*phase_rot);
% K(:,:,:,1:(end-1))=PR_mig(:,:,:,1:end-1).*conj(PR_mig(:,:,:,2:end));
show_retrieved(K(:,:,:,:),f,z);

% show_volume_all(abs(PR(:,:,:,1)),x,y,l(index_distance)/2,jet)
% show_volume_all(abs(PR(:,:,:,40)),x,y,l(index_distance)/2,jet)
% show_volume_all(abs(PR(:,:,:,80)),x,y,l(index_distance)/2,jet)
% show_volume_all(abs(PR(:,:,:,120)),x,y,l(index_distance)/2,jet)
% show_volume_all(abs(PR(:,:,:,160)),x,y,l(index_distance)/2,jet)
% show_volume_all(abs(PR(:,:,:,200)),x,y,l(index_distance)/2,jet)

show_volume_all(angle(K(:,:,:,40)),x,y,l(index_distance)/2,hsv)
show_volume_all(angle(K(:,:,:,80)),x,y,l(index_distance)/2,hsv)
show_volume_all(angle(K(:,:,:,120)),x,y,l(index_distance)/2,hsv)
show_volume_all(angle(K(:,:,:,160)),x,y,l(index_distance)/2,hsv)
show_volume_all(angle(K(:,:,:,200)),x,y,l(index_distance)/2,hsv)
%% SOMの学習

disp('SOM studying');
alpha = 0.8; beta = alpha/5; %α,βの値
loop = 50; % 参照ベクトルの更新回数

w_points = 8; % 参照ベクトルの数

[w,c] = SOM_batch(K,w_points,loop,alpha,beta);
% [w,c] = SOM_batch_angle(K,w_points,loop,alpha,beta);
% [w,c] = SOM_batch_2D(K,w_points,loop,alpha,beta);
%% 位相復元結果の補正，検証
K2 = squeeze(mean(10*log10(abs(K)),[1 2])); % 深さと周波数の関係を調べる

% 最大0dBになるように正規化
% K2m = max(K2,[],2);
% K2 = K2./K2m;
% K2 = K2-K2m;
% imagesc(abs(K2));

% 平均0dBになるように正規化
K2m = mean(K2,1); % 周波数方向の平均
K2 = K2-K2m;
K2m = mean(K2,2); % 深さ方向の平均
K2 = K2-K2m;

% 周波数全体の深さ方向の強度分布を引き算
% L2 = reshape(mean(10*log10(abs(s_time(:,:,index_distance))),[1 2]),N_pr,1);
% figure;
% plot(l(index_distance)/2,L2);
% xlabel('distance[m]');
% ylabel('amplitude[dB]');
% K2 = K2-L2;

% 空間全体の周波数領域での強度分布を引き算
% M2 = reshape(freq_data,1,Nf);
% K2 = K2-M2;
% figure;
% plot(f,M2);
% xlabel('distance[m]');
% ylabel('amplitude[dB]');

% 周波数-深さで強度分布を表示
% figure;
% ax = gca;
% surf(f,lpr/2,K2,'edgecolor','none');
% ax.YDir = 'reverse';
% view(0,90)
% colormap(jet);
% cbar = colorbar;
% cbar.Label.String = 'amplitude[dB]';
% % cbar.Label.String = 'amplitude[arb.]';
% % caxis([5 21]);
% xlabel('frequency[Hz]');
% ylabel('depth[m]');
% zlabel('amplitude[db]');

clear K2m K2;
%% 位相復元結果の補正，検証その2
K2 = reshape(10*log10(abs(K)),[],N_pr,Nf); % 深さと周波数の関係を調べる

% 最大0dBになるように正規化
K2m = max(K2,[],2);
% K2 = K2./K2m;
K2 = K2-K2m;
K2m = max(K2,[],3);
K2 = K2-K2m;
imagesc(squeeze(mean(K2,1)));

% 平均0dBになるように正規化
% K2m = mean(K2,3); % 周波数方向の平均
% K2 = K2-K2m;
% K2m = mean(K2,2); % 深さ方向の平均
% K2 = K2-K2m;

% 周波数全体の深さ方向の強度分布を引き算
% L2 = reshape(mean(10*log10(abs(s_time(:,:,index_distance))),[1 2]),N_pr,1);
% K2 = K2-L2;
% figure;
% plot(l(index_distance),L2);
% xlabel('distance[m]');
% ylabel('amplitude[dB]');

% 空間全体の周波数領域での強度分布を引き算
% M2 = reshape(freq_data,1,Nf);
% K2 = K2-M2;
% figure;
% plot(f,M2);
% xlabel('distance[m]');
% ylabel('amplitude[dB]');

% show_volume(permute(K2(1:Nx,:,:),[2 3 1]),l(index_distance)/2,f,1:Nx,jet);
show_volume_all(permute(K2(1:Nx,:,:),[2 3 1]),l(index_distance)/2,f,1:Nx,jet);

clear K2m K2;
% 位相復元結果を反映したdft行列を作成
%% ifft
clc;

% 使用する計測データを選択
Nzp = size(index_distance,2);
index_x = 1:Nx;
index_y = 1:Ny;
index_f = 1:Nf;
s_use = s_cd(index_x,index_y,index_f);
% s_use = s_use./abs(s_use);
[Nxm,Nym,Nfm] = size(s_use);


disp('migrating...')
bar = waitbar(0,'Migrating');
tic;

xp = reshape(x,Nx,1,1); % reflected position in x-axis
yp = reshape(y,1,Ny,1); % reflected position in y-axis
zp = reshape(l(index_distance)/2,1,1,Nzp); % reflected position in z-axis
xm = reshape(x,1,1,1,Nx); % measuring position in x-axis
ym = reshape(y,1,1,1,1,Ny); % measuring position in y-axis
fm = reshape(f,1,1,1,1,1,Nf); % measuring frequency


xm = xm(index_x);
ym = ym(index_y);
fm = fm(index_f);

% 位相復元の結果から重みづけインデックスを作成
% PRdb = 10*log10(PRamp);
% PRdb = PRdb-max(PRdb,3);
% PRdb = PRdb-max(PRdb,6);
% PRw = 10.^(PRdb/10);
% clear PRdb;
% PRw = PRw(:,:,:,:,:,index_f);


[d_h,d_v,f_dir] = read_directivity;
index_fdir = zeros(1,Nfm);
for i = 1:Nfm
    index_fdir(i) = find(f_dir==fm(i));
end
d_h = d_h(:,index_fdir);
d_v = d_v(:,index_fdir);



dt = 1/Nx/Ny;

p = zeros(Nx,Ny,Nzp); % spatial image

for xi = 1:Nx % reflected position index in x-axis
    for yi = 1:Ny % reflected position index in y-axis
        R1 = sqrt((-0/2).^2+zp.^2); % incidence path length
        R2 = sqrt(0/2.^2+zp.^2); % reflection path length
        temp = reshape(s_use(xi,yi,:),1,1,1,1,1,Nfm).*exp(1i*2*pi*fm.*(R1+R2)/nu); % rotation of phase;
%         temp = temp.*PRw(xi,yi,:,:,:,:); % 位相復元結果の周波数特性を重み付けする
%         temp = temp.*(R1.*R2).^2; % correct distance attenuation of signals

        % 指向性による補正
%         theta_v1 = round(atan((xm-d/2-xp(xi))./zp)/pi*180+181); % angle from TX in x-direction
%         theta_v2 = round(atan((xm+d/2-xp(xi))./zp)/pi*180+181); % angle from RX
%         theta_h = round(atan((ym-yp(yi))./zp)/pi*180+181); % angle
%         temp = conj(reshape(d_v(theta_v1,:).*d_v(theta_v2,:),1,1,Nzp,Nxm,1,Nfm)...
%             .*reshape(d_h(theta_h,:).^2,1,1,Nzp,1,Nym,Nfm))...
%             .*temp;

        p(xi,yi,:) = p(xi,yi,:) + sum(temp,[4 5 6]); % sum signals from all antenna positions
        waitbar(dt*(yi+Ny*(xi-1)),bar,'Migrating');
    end
end
clear temp R1 R2 dir theta_v1 theta_v2 theta_h dir_temp1 dir_temp2;
p = p/Nx/Ny/Nf; % devide with number of reflection positions

close(bar);
toc;

show_volume(abs(p),x,y,zp,jet);
show_volume(angle(p),x,y,zp,hsv);


%% f-migration
clc;

% 使用する計測データを選択
Nzp = size(index_distance,2);
index_x = 1:Nx;
index_y = 1:Ny;
index_f = 1:140;
s_use = s_cd(index_x,index_y,index_f);
% s_use = s_cd_filtered(index_x,index_y,index_f);
f_use = f(index_f);
s_use = s_use./abs(s_use);
[Nxm,Nym,Nfm] = size(s_use);
index_z = find(0.4<z & z<0.6);
z_use = z(index_z);

B = f_migration(s_use,x,y,z_use,x(index_x),y(index_y),f_use,d,h,g);

show_volume(abs(B),x,y,z_use,jet);
show_volume(angle(B),x,y,z_use,hsv);

%% Kirchhoff Migration
t = l/nu;
B = k_migration(s_time,x,y,l/2,t,index_distance);
%% migration結果から位相復元
B_pad = zeros(size(s_time)); % 逆フーリエ変換時のサイズのデータ配列を初期化
B_pad(:,:,index_z) = B; % 該当部分にmigration結果を代入

PR_mig = phase_retrieval(B_pad,0.03,Nfft,l,index_z,index_frequency(index_f));

%% 位相復元結果表示

K = PR_mig;
f_use = f(index_f);

% 深さ方向の位相回転キャンセル
% phase_rot = reshape(l(index_distance)-l(index_distance(1)),1,1,[])/nu.*reshape(f_use,1,1,1,[])*2*pi; 
% K = PR_mig.*exp(-1i*phase_rot);

% K = ones(size(PR_mig)).*exp(-1i*phase_rot); % 位相のみを取り出す。
% K(:,:,:,1:(end-1))=PR_mig(:,:,:,1:end-1).*conj(PR_mig(:,:,:,2:end)); % 周波数方向の自己相関をとる
% K(:,:,:,end)=[]; f_use(end)=[];

show_retrieved(K,f,l(index_distance)/2);

% show_retrieved(K(30,25,:,:),f,l(index_distance)/2);
% show_retrieved(K(30,40,:,:),f,l(index_distance)/2);
% show_retrieved(K(19,14,:,:),f,l(index_distance)/2);
% show_retrieved(K(30,40,:,:),f,l(index_distance)/2);

% cmap = gray;
% th = 140;
% cmap(1:th,:) = 1;
% cmap(th+1:end,:) = 0;
% show_volume_all(abs(PR_mig(:,:,:,1)),x,y,l(index_distance)/2,jet)
% show_volume_all(abs(PR_mig(:,:,:,40)),x,y,l(index_distance)/2,jet)
% show_volume_all(abs(PR_mig(:,:,:,80)),x,y,l(index_distance)/2,jet)
% show_volume_all(abs(PR_mig(:,:,:,120)),x,y,l(index_distance)/2,jet)
% show_volume_all(abs(PR_mig(:,:,:,160)),x,y,l(index_distance)/2,jet)
% show_volume_all(abs(PR_mig(:,:,:,200)),x,y,l(index_distance)/2,jet)
% show_volume_all(angle(K(:,:,:,1)),x,y,l(index_distance)/2,cmap)
% show_volume_all(angle(K(:,:,:,40)),x,y,l(index_distance)/2,cmap)
% show_volume_all(angle(K(:,:,:,80)),x,y,l(index_distance)/2,cmap)
% show_volume_all(angle(K(:,:,:,120)),x,y,l(index_distance)/2,cmap)
% show_volume_all(angle(K(:,:,:,160)),x,y,l(index_distance)/2,hsv)
% show_volume_all(angle(K(:,:,:,200)),x,y,l(index_distance)/2,hsv)

% ３か所の復元した位相を比較
% phase_mine = squeeze(K(28:32,22:27,158-index_distance(1)+1,:)); % 地雷付近の位相復元結果
% phase_bottom = squeeze(K(18:46,13:41,184-index_distance(1)+1,:)); % 容器底面付近の位相復元結果
% phase_surface = squeeze(K(18:46,13:41,157-index_distance(1)+1,:)); % 地表付近の位相復元結果
% phase_mine = squeeze(K(12:25,9:18,63,:)); % 缶付近の位相復元結果
% phase_bottom = squeeze(K(33:46,13:41,81,:)); % 容器底面付近の位相復元結果
% phase_surface = squeeze(K(18:46,13:41,54,:)); % 地表付近の位相復元結果
% 行列の形に変形
% phase_mine = reshape(phase_mine,[],numel(f_use))'; 
% phase_bottom = reshape(phase_bottom,[],numel(f_use))';
% phase_surface = reshape(phase_surface,[],numel(f_use))';
% それぞれの標準偏差と平均値のプロット
% 振幅
% p = plot_std(f_use,abs(phase_mine),f_use,abs(phase_bottom),f_use,abs(phase_surface));
% legend([p{1} p{2} p{3}],'mine','bottom','surface');
% xlabel('frequency[Hz]');
% ylabel('Amplitude');
% 位相
% p = plot_std(f_use,unwrap(angle(phase_mine)),f_use,unwrap(angle(phase_bottom)),f_use,unwrap(angle(phase_surface)));
% legend([p{1} p{2} p{3}],'mine','bottom','surface');
% xlabel('frequency[Hz]');
% ylabel('Phase[rad]');

% cmap = gray;
% cmap(1:110,:) = 0;
% cmap(111:end,:) = 1;
% show_4D_all(angle(K),x,y,l(index_distance)/2,f_use,cmap)
%% SOMの学習

disp('SOM studying');
alpha = 0.8; beta = alpha/5; %α,βの値
loop = 50; % 参照ベクトルの更新回数

w_points = 8; % 参照ベクトルの数

[w,c] = SOM_batch(K,w_points,loop,alpha,beta);
show_all_class(c,w_points);
% [w,c] = SOM_batch_angle(K,w_points,loop,alpha,beta);
% [w,c] = SOM_batch_2D(PR_mig,w_points,loop,alpha,beta);

%% mig_PR
[pr_x,pr_y,pr_z,fx,fy,fz] = mig_PR(B,x,y,l(index_distance)/2,f_use);

figure;
plot(fx,abs(pr_x)); hold on;
plot(fy,abs(pr_y)); hold on;
plot(fz,abs(pr_z)); hold on;
legend('$x$','$y$','$z$');
xlim([f_use(1) f_use(end)]);
xlabel('Frequency[Hz]');
ylabel('Amplitude');

figure;
plot(fx,unwrap(angle(pr_x))); hold on;
plot(fy,unwrap(angle(pr_y))); hold on;
plot(fz,unwrap(angle(pr_z))); hold on;
legend('$x$','$y$','$z$');
xlim([f_use(1) f_use(end)]);
xlabel('Frequency[Hz]');
ylabel('Phase[rad]')
%% k-means法
[w,c] = k_means(K,w_points,loop);

%% 関数テスト
f = make_dfilter(0.46,0.61,l/2);
figure; plot(l/2,f);
xlim([0.3,0.7]);
%% 関数定義セクション

% 0を頂点とするガウス関数出力
function f = gaussian(x,s)
N = size(x,2);
Nxc = floor(N/2);
f = exp(-(x-x(Nxc)).^2/2/s^2); % ガウス分布
f = circshift(f,-Nxc+1,2);
f = reshape(f,[1,1,N]); 
end

% アンテナの周波数特性を読み込んで出力
function amp = fchar(f) 
nu = physconst('Lightspeed');
filename = 'directivity_h_near.txt'; % アンテナ間約0.6m
A = readmatrix(filename);
d = A(2:end,2:end); % ラベル除去
d_sum = sum(d,2); % それぞれの角度でのゲインを足し合わせる
[M,I] = max(d_sum); % 最もゲインが高い角度を確認
d = circshift(d,181-I,1); % 中央(181セル目)が最大になるようにシフト
f_load = A(1,2:end);

Nf = size(f,2);
index = zeros(1,Nf); % 使用する周波数のインデックス

for i = 1:Nf
   
    index(i) = find(f_load==f(i));
end
f_load = f_load(index);
d_f = d(180,index); % 正面方向の周波数特性
d_t = 20*log10(nu/pi/4/0.6)-20*log10(f); % 周波数ごとの距離減衰を計算
amp = d_f-d_t; % 周波数ごとの距離減衰を補正してアンテナの周波数特性を抽出
% amp = d_f;
amp = 10.^(amp/10);
end

% 表面散乱，容器底面の散乱を除去するためのフィルタ
function f = make_dfilter(d1,d2,l)
s = 0.01; % 分散
temp = exp(-((l-d1)/s).^2) + exp(-((l-d2)/s).^2);
f = 1-temp*0.5;
end