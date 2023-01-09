

% Ground Bounce Removal
% M. A. C. Tuncer and A. C. Gurbuz, "Ground Reflection Removal in Compressive Sensing Ground Penetrating Radars," in IEEE Geoscience and Remote Sensing Letters, vol. 9, no. 1, pp. 23-27, Jan. 2012, doi: 10.1109/LGRS.2011.2158981.

function obj = GBR(obj)
nu = physconst('lightspeed');

B = obj.S; % 計測データ
f = obj.f; % 周波数
z = obj.zp; %深さ軸
g = obj.g; % カリブレーション点から謎のギャップ
h = obj.h; %アンテナ高さ
d = obj.d; %アンテナ間距離
dd = 0.01; % allowable error of antenna height
dtau = dd*4/nu;
N = 100;
[Nx,Ny,Nf] = size(B);
gi = zeros(Nx,Ny,Nf);

Bm = B-mean(B,'all');
tau0 = (2*g+sqrt(4*h^2+d^2))/nu;
gr = exp(-1i*2*pi*f*tau0);
ddtau = dtau/N;
cor = zeros(Nx,Ny);
max = zeros(Nx,Ny);
hlis = zeros(Nx,Ny);
for k = -N/2:N/2
    git = reshape(gr.*exp(1i*2*pi*f*ddtau*k),1,1,Nf); % 時間遅れを少しずつずらす
    cor_temp = sum(Bm.*conj(git),3); % 計測データとの周波数方向の相関をとる
    cor_a = abs(cor_temp);
    temp_h = sqrt(((tau0+ddtau*k)*nu-2*g)^2-d^2)/2; % 時間遅れからアンテナ高さを計算する
    I = find(max<cor_a); % 相関が高い座標を検索
    max(I) = cor_a(I); % 相関が高かったものは相関値の記録を更新
    cor(I) = cor_temp(I);
    hlis(I) = temp_h; % 同様にアンテナ高さを更新
    [I1,I2] = ind2sub([Nx Ny],I);
    for i = 1:numel(I)
        gi(I1(i),I2(i),:) = git; % 時間遅れを更新
    end
end

obj.h = mean(hlis,'all');
% Bf = sqrt(abs(mean(B,[1 2])));
% Bf = mean(abs(B),[1 2]);
Bf = abs(B);
GB = 1*cor.*gi.*Bf./mean(Bf,3)/Nf;
% GB = 1*cor.*gi/Nf;
obj.S = B - GB;
% obj.S = GB;

% figure;
% imagesc(hlis);