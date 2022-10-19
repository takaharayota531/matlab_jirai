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

% load measured data
dataFolder='data\';
dataFile='1009_metalpipe_(15,0,2.5)';
dataname = append(dataFolder,dataFile);
dataHname = 'hosei(1-21GHz401points)_paralell';
dataH_nanimonashi='data/0926_nanimonashi_ydirection';
% [s,f] = data_load_XY_raw(dataname);
%[s,f] = data_load_without_correction(dataname,dataHname);
%[s,f]=data_load_py_takahara(dataname,dataH_nanimonashi);
[s,f] = data_load_py(dataname,dataHname);
f = round(f); % correct digit
index = 1:200; % 周波数選択(1:1GHz~400:21GHz)持ってくる周波数帯域を選んでいる
s = s(:,:,index);
f = f(index);
[Nx,Ny,Nf] = size(s);%Nf-1になっているのでは？
x_int = 0.005; % x-interval
y_int = 0.005; % y-interval
z_int = 0.005; % z-interval
h = 0.2; % height of antennas
g = 0.19; % gap from caliblation point to アンテナの先端
d = 0.06; % distance between antennas
nu = physconst('Lightspeed'); % light speed
er = 4; % relative permittivity

x = 0:x_int:x_int*(Nx-1); % x-positions
y = 0:y_int:y_int*(Ny-1); % y-positions
z = 0.2:z_int:0.65; % z-positions
Nz = size(z,2);%zの要素数→zについていくつ値をとったか
%% 周波数などもろもろの補正

%s_cd = s; % 補正済み散乱係数　moved
f = round(f); % 変な端数の丸め
% ./ →対応する各要素で割り算すればいい
s_cd = s./reshape(fchar(f),1,1,Nf); % アンテナの周波数特性の補正

% 周波数ごとの距離減衰 点散乱源を仮定した補正f^4　面反射の場合はf^2
%対応する要素で掛け算する
s_cd = s_cd.*reshape(f.^4,1,1,Nf);

s_cd = s_cd/max(abs(s_cd),[],'all'); % 振幅の最大値を1(0dB)に正規化
s_cd_sq=squeeze(s_cd);

%% ランダムデータ抽出

sparse_k=5;%スパース
[datanum_n,freq_point]=size(s_cd_sq);
sampling_data=zeros(datanum_n,freq_point);
index=randperm(datanum_n,sparse_k);
index
for i=1:sparse_k 
    sampling_data(index(i),:)=s_cd_sq(index(i),:);
end




%% 時間領域分析、処理  ここまで実行する

% 周波数点数（周波数分解能）を補間によって増加


% 逆フーリエ変換で時間領域に変換
START_FREQ = f(1);%初期周波数まじで一つ値ずれてる
df = f(2)-f(1); % 周波数ステップ幅
%floor:その値以下で最も近い整数
N_head = floor(START_FREQ/df); % START_FREQまでの埋めるべき周波数点数
% Nfft = N_head+Nf;
Nfft = 1024;
s_shifted = zeros(Nx,Nfft); % 埋める周波数を含めた周波数応答格納配列
% ind = 1:Nf;
% ind([157 200])=0;
% ind = ind>0;
% s_cd(:,:,ind)=0;
%% ifft
%TODO 高原ここらへんからわからんくなった
s_shifted(:,N_head+1:N_head+Nf) = s_cd_sq(:,:);%周波数軸で見ればいい
s_shifted_sampled(:,N_head+1:N_head+Nf) = sampling_data(:,:);%周波数軸で見ればいい

% plot(squeeze(s_shifted(1,1,:)));
%%
s_time = ifft(s_shifted,Nfft,2);%逆フーリエ変換
s_time_sampled=ifft(s_shifted_sampled,Nfft,2);
time_data = mag2db(squeeze(sum(abs(s_time_sampled),1))); % xyの次元をまとめた時の時間領域の特性
 figure;
 plot(time_data);
 xlabel('time[s]');
 ylabel('amplitude[dB]');
 %s_changed_time=make_average(s_time);
%% 時間領域の幅
T = 1/df; % 時間領域の最大値
dt = T/Nfft; % 伝搬時間分解能
L = T*nu; % 空間領域の最大値
dl = L/Nfft; % 伝搬距離分解能
t = (0:Nfft-1)*dt; % 伝搬時間
l = (0:Nfft-1)*dl; % 伝搬距離
%z = [l(l/2<h+g)/2 l(l/2>h+g)/2/sqrt(er)+(h+g)*(1-1/sqrt(er))];
%結局使われているのこっちで草
%z = l/2;
% s_time = s_time.*reshape((l/2).^4,1,1,Nfft); % 伝搬距離による減衰の補正（自由空間を仮定）

% データ全体の時間領域の傾向をプロット
% figure;
%plot(l/2,time_data);
%xlabel('distance[m]');
%ylabel('amplitude[dB]');

% 表面と容器底面の散乱を除去
time_data = db2mag(time_data);
%% 表示プロット 
% ある深さ幅の位相と振幅表示
index_distance = find( 0.2<l/2&l/2<0.4);
index_frequency = N_head+1:N_head+Nf; % 位相復元する周波数の範囲
% index_distance = 1:Nfft;


%s_time_filtered_sq=squeeze(s_time_filtered);
s_time_sq=squeeze(s_time);
s_time_sampled_sq=squeeze(s_time_sampled);
%% init_model
f1=figure;
show_w(s_time_sq(:,index_distance),f1);
%% model_check
model_check=make_model_alongline(8,s_time_sq);

%% interpolate
 a=10000;
 scattering_interpolated=interpolate_calculate(s_time_sampled_sq,index,dl,x_int,sparse_k,a);
%% true plot
f=figure;
f1=figure;
% f2=figure;
% f3=figure;
show_w(s_time_sq(:,index_distance),f1);
sca=mag2db(abs(scattering_interpolated));
show_w(scattering_interpolated(:,index_distance),f);
%show_w(scattering_interpolated(:,index_distance),f1);
 %show_w(s_time_sampled_sq(:,index_distance),f2);
 show_w(s_time_sampled_sq(:,index_distance),f1);
% show_volume_amp((abs(s_time(:,:,index_distance))),x,y,l(index_distance)/2,jet,dataname); % フィルタ処理前の表示
% show_volume_angle((angle(s_time(:,:,index_distance))),x,y,l(index_distance)/2,hsv,dataname);

% show_volume_amp(abs(s_changed_time(:,:,index_distance)),x,y,l(index_distance)/2,jet,dataname); % フィルタ処理前の表示
% show_volume_angle((angle(s_changed_time(:,:,index_distance))),x,y,l(index_distance)/2,hsv,dataname);
% db_magnitude=mag2db(abs(s_time_filtered(:,:,index_distance)));
% show_volume_amp(abs(s_time_filtered(:,:,index_distance)),x,y,l(index_distance)/2,jet,dataname); % フィルタ処理前の表示
% show_volume_angle((angle(s_time_filtered(:,:,index_distance))),x,y,l(index_distance)/2,hsv,dataname);
% show_volume((abs(s_time_filtered(:,:,index_distance))),x,y,l(index_distance)/2,jet); % フィルタ処理後の表示
% show_volume(angle(s_time_filtered(:,:,index_distance)),x,y,l(index_distance)/2,hsv);

% plot(l(index_distance)/2,squeeze(mean(abs(s_time(:,:,index_distance)),[1 2]))');

% s_cd_filtered = fft(s_time_filtered,Nfft,3);







%% 関数定義セクション

% 0を頂点とするガウス関数出力
function f = gaussian_1dim(x,s)
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