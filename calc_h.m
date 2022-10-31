% 半径rの円の内部と外側を比較

function h = calc_h(k,model)
    [Nx,Ny,k_dim] = size(k);
    %すべてのモデルについて相関度を計算しそのモデルでの特徴ベクトルの平均をとる．
    mx = size(model,1);
    my=size(model,2);
    rx = floor(mx/2);
    ry = floor(my/2);
    h = zeros(Nx,Ny); %各モデルでの数値を格納
    % Ix = [r:-1:1,1:Nx,Nx:-1:Nx-r+1];
    % Iy = [r:-1:1 1:Ny Ny:-1:Ny-r+1];
    Ix = [Nx-rx+1:Nx,1:Nx,1:rx];
    Iy = [Ny-ry+1:Ny,1:Ny,1:ry];
    %この二式が全然わからん　todo高原
    %ここの式反対側を参照しないように書き換えておく
    for x = 1:Nx
        for y = 1:Ny
            kp = squeeze(sum((model==1).*k(Ix(x:x+mx-1),Iy(y:y+my-1),:),[1 2]));
            km = squeeze(sum((model==-1).*k(Ix(x:x+mx-1),Iy(y:y+my-1),:),[1 2]));
            h(x,y) = 1-real(kp'*km)/sqrt(kp'*kp)/sqrt(km'*km);
        end
    end
    
    [M I] = max(h,[],'all','linear');
    [ii, jj] = ind2sub(size(zeros(Nx-mx+1,Ny-my+1)), I);
    pos = [mod(I,(Nx-mx+1)) floor(I/(Nx-my+1))];
    %posの指定の仕方の変更
     [ii, jj] = ind2sub(size(zeros(Nx-mx+1,Ny-my+1)), I);
     pos=[ii,jj];
     display_position(pos,model,Nx,Ny);
    
    end
    
    function display_position(pos,model,Nx,Ny)
    land = zeros(Nx,Ny);
    Nmx = size(model,1);
    Nmy=size(model,2);
    for x = 1:Nmx
        for y = 1:Nmy
            if model(x,y) == 1
                land(pos(1)+x-1,pos(2)+y-1) = 1;
            end
        end
    end
    figure;
    imagesc(land);
    colormap(gray);
    end
    
        