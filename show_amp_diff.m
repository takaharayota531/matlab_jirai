function show_amp_diff(target1,target2,f,dataname,depth_start,depth_end)
    f = round(f); % correct digit
    index = 1:200; % 周波数選択(1:1GHz~400:21GHz)持ってくる周波数帯域を選んでいる
  
    [Nx,Ny,Nf] = size(target1);%Nf-1になっているのでは？
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
    START_FREQ = f(1);%初期周波数まじで一つ値ずれてる
    df = f(2)-f(1); % 周波数ステップ幅
    %floor:その値以下で最も近い整数
    N_head = floor(START_FREQ/df); % START_FREQまでの埋めるべき周波数点数
    % Nfft = N_head+Nf;
    Nfft = 1024;
    T = 1/df; % 時間領域の最大値
    dt = T/Nfft; % 伝搬時間分解能
    L = T*nu; % 空間領域の最大値
    dl = L/Nfft; % 伝搬距離分解能
    t = (0:Nfft-1)*dt; % 伝搬時間
    l = (0:Nfft-1)*dl; % 伝搬距離

    index_distance = find( depth_start<l/2&l/2<depth_end);
    
    %index_distance = find(l);
    %index_frequency = N_head+1:N_head+Nf; % 位相復元する周波数の範囲
    % index_distance = 1:Nfft;


    ans_diff=abs(target1)-abs(target2);
    show_volume_amp(ans_diff(:,:,index_distance),x,y,l(index_distance)/2,jet,dataname,'non_filter'); % フィルタ処理前の表示