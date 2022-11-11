%出来上がったデータのマイグレーション処理とプロットまでを行う
function s_time= migration_and_plot_polarization(s,f,dataname,depth_start,depth_end)

    % 初期設定
    % [s,f] = data_load_XY_raw(dataname);
    %[s,f] = data_load_without_correction(dataname,dataHname);
    %[s,f]=data_load_py_takahara(dataname,dataH_nanimonashi);
    %[s,f] = data_load_py(dataname,dataHname);
    f = round(f); % correct digit
    % index = 1:200; % 周波数選択(1:1GHz~400:21GHz)持ってくる周波数帯域を選んでいる
    % s = s(:,:,index);
    % f = f(index);
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
    
    
    %周波数などもろもろの補正
    
    %s_cd = s; % 補正済み散乱係数　moved
    f = round(f); % 変な端数の丸め
    % ./ →対応する各要素で割り算すればいい
    s_cd = s./reshape(fchar(f),1,1,Nf); % アンテナの周波数特性の補正
    
    % 周波数ごとの距離減衰 点散乱源を仮定した補正f^4　面反射の場合はf^2
    %対応する要素で掛け算する
    s_cd = s_cd.*reshape(f.^4,1,1,Nf);
    
    s_cd = s_cd/max(abs(s_cd),[],'all'); % 振幅の最大値を1(0dB)に正規化
    %平均してから対数をとるか、対数を取ってから平均
    % freq_data = squeeze(mean(10*log10(abs(s_cd)),[1 2]));
    % figure;
    % plot(f,freq_data);
    % xlabel('frequency[Hz]');
    % ylabel('amplitude[dB]');
    % xlim([1 11]*1e9);
    freq_data = 10*log10(squeeze(mean(abs(s_cd),[1 2])));
    
    % データ全体の周波数領域の特徴をプロット
    % figure;
    % plot(f,freq_data);
    % xlabel('frequency[Hz]');
    % ylabel('amplitude[dB]');
    % xlim([1 11]*1e9);
    
    
    % 時間領域分析、処理  ここまで実行する
    
    % 周波数点数（周波数分解能）を補間によって増加
    
    
    % 逆フーリエ変換で時間領域に変換
    START_FREQ = f(1);%初期周波数まじで一つ値ずれてる
    df = f(2)-f(1); % 周波数ステップ幅
    %floor:その値以下で最も近い整数
    N_head = floor(START_FREQ/df); % START_FREQまでの埋めるべき周波数点数
    % Nfft = N_head+Nf;
    Nfft = 1024;
    s_shifted = zeros(Nx,Ny,Nfft); % 埋める周波数を含めた周波数応答格納配列
    % ind = 1:Nf;
    % ind([157 200])=0;
    % ind = ind>0;
    % s_cd(:,:,ind)=0;
    
    % ifft
    
    %TODO 高原ここらへんからわからんくなった
    s_shifted(:,:,N_head+1:N_head+Nf) = s_cd(:,:,:);%周波数軸で見ればいい
    
    %plot(squeeze(s_shifted(1,1,:)));
    %
    s_time = ifft(s_shifted,Nfft,3);%逆フーリエ変換
    time_data = mag2db(squeeze(sum(abs(s_time),[1 2]))); % xyの次元をまとめた時の時間領域の特性
    
    %  figure;
    %  plot(time_data);
    %  xlabel('time[s]');
    %  ylabel('amplitude[dB]');
    %s_changed_time=make_average(s_time);
    
    % 時間領域の幅
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
    %最も大きいデータのインデントをとってきている
    [~,I1] = max(time_data); % 1つ目のピークを探索
    gwin = gaussian(l/2,0.08); % ガウスウィンドウを作成
    %  figure;
    %  plot(squeeze(gwin));
    gwin = circshift(gwin,I1,3); % ガウス窓をピークの位置にシフト
    %  figure;
    %  plot(time_data);
    
    
    % plot
    %  [xw,yw,zw]=meshgrid(0:x_int:x_int*(Nx-1), 0:y_int:y_int*(Ny-1),0:100:1024);
    %  d=slice(xw,yw,zw,s_time,0,0,500);
    %  shading flat;
    %  axis vis3d;
    %  colormap(jet);
    
    
    
    % cal
    s_time_filtered = (s_time-s_time.*gwin);
    %time_data_filtered = mag2db(squeeze(sum(abs(s_time_filtered),[1 2])));
    % 
    % [~,I2] = max(time_data_filtered); % 2つ目のピークを探索
    % gwin = gaussian(l/2,0.02); % ガウスウィンドウを作成
    % gwin = circshift(gwin,I2,3); % ガウス窓をピークの位置にシフト
    % s_time_filtered = s_time_filtered-s_time_filtered.*gwin;
    % time_data_filtered = mag2db(squeeze(sum(abs(s_time_filtered),[1 2])));
    
    
    %  figure;
    %  plot(l/2,squeeze(s_time_filtered(1,1,:)));
    %  xlim([0,1.0]);
    %  xlabel('distance[m]');
    %  ylabel('amplitude[dB]');
    
    
    
     
    % 表示プロット 
    % ある深さ幅の位相と振幅表示
    index_distance = find( depth_start<l/2&l/2<depth_end);
    
    %index_distance = find(l);
    index_frequency = N_head+1:N_head+Nf; % 位相復元する周波数の範囲
    % index_distance = 1:Nfft;
    
%     
     show_volume_amp(abs(s_time(:,:,index_distance)),x,y,l(index_distance)/2,jet,dataname,''); % フィルタ処理前の表示
     show_volume_angle((angle(s_time(:,:,index_distance))),x,y,l(index_distance)/2,hsv,dataname);
%     
    
    
    %db_magnitude=mag2db(abs(s_time_filtered(:,:,index_distance)));
    % abs_dB=mag2db(abs(s_time_filtered(:,:,index_distance)));
    % show_volume_amp(abs(s_time_filtered(:,:,index_distance)),x,y,l(index_distance)/2,jet,dataname,'filtered'); % フィルタ処理前の表示
    % show_volume_angle(angle(s_time_filtered(:,:,index_distance)),x,y,l(index_distance)/2,hsv,dataname);
    show_volume_amp((abs(s_time_filtered(:,:,index_distance))),x,y,l(index_distance)/2,jet,dataname,''); % フィルタ処理後の表示
    show_volume_angle(angle(s_time_filtered(:,:,index_distance)),x,y,l(index_distance)/2,hsv,dataname);
    
    % plot(l(index_distance)/2,squeeze(mean(abs(s_time(:,:,index_distance)),[1 2]))');
    
    % s_cd_filtered = fft(s_time_filtered,Nfft,3);
    
    
    
    end
    
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