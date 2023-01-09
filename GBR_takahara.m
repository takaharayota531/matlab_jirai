% ground bounce removal

function removed_data=GBR_takahara(B,f,g,h,d,er)
%     er=6;
    % nu = physconst('lightspeed')/sqrt(er);
    nu = physconst('lightspeed');
    dd = 0.01; % allowable error of antenna height
    dtau=dd*4/nu;
    N=100;
    [Nx,Ny,Nf]=size(B);
    gi=zeros(Nx,Ny,Nf);

    Bm=B-mean(B,"all");
    tau0=(2*g+sqrt(4*h^2+d^2))/nu;
    gr=exp(-1i*2*pi*f*tau0);
    ddtau=dtau/N;
    cor=zeros(Nx,Ny);
    max=zeros(Nx,Ny);
    hlis=zeros(Nx,Ny);

    for k=-N/2:N/2
        git =reshape(gr.*exp(1i*2*pi*f*ddtau*k),1,1,Nf); % 時間遅れを少しずつずらす
        cor_temp = sum(Bm.*conj(git),3); % 計測データとの周波数方向の相関をとる
        cor_a=abs(cor_temp);

        temp_h=sqrt(((tau0+ddtau*k)*nu-2*g)^2-d^2)/2;  % 時間遅れからアンテナ高さを計算する
        I=find(max < cor_a); % 相関が高い座標を検索
        max(I) = cor_a(I);
        cor(I) = cor_temp(I);
        hlis(I) = temp_h;
        [I1,I2]=ind2sub([Nx Ny], I);
        for i=1:numel(I)
            gi(I1(i),I2(i),:)=git;
        end

    end

    h=mean(hlis,"all");
    Bf=abs(B);

    GB=1*cor.*gi.*Bf./mean(Bf,3)/Nf;

    removed_data=B-GB;




end