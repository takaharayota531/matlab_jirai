function [h,K]= ...
    CS_optimization_calc_h(s,sample,model,p,FREQ_POINT,E_iH,E_iV)%散乱画像、ウィンドウサイズ、モデルサイズ
    %s:補間後の散乱画像
    %sample:測定位置の値を1としている
    %model:モデル
    %p:評価関数のノルム
    %his:historyの略

    Ns=sum(sample(:,:,1),'all');%取り出したデータの数
    m=size(model,1);

    % S_h=calc_h(s(1:4*FREQ_POINT),model);%TODO ここ最初からその他の情報を含むことができていない
    % データの比率を一緒にしている
    S_HH=s(:,:,1:FREQ_POINT);
    S_HV=s(:,:,FREQ_POINT+1:2*FREQ_POINT);
    S_VH=s(:,:,2*FREQ_POINT+1:3*FREQ_POINT);
    S_VV=s(:,:,3*FREQ_POINT+1:4*FREQ_POINT);
    % E_iH=0;
    % E_iV=1;
    [g0,g1,g2,g3] = calc_stokes_vector_full_polarimetry(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV) ;
    % added_poincare_vector1=cat(3, g1./g0, g1./g0, g1./g0, g1./g0)/4;
    % added_poincare_vector2=cat(3, g2./g0, g2./g0, g2./g0, g2./g0)/4;
    % added_poincare_vector3=cat(3, g3./g0, g3./g0, g3./g0, g3./g0)/4;

    % s=cat(3,s,added_poincare_vector1,added_poincare_vector2,added_poincare_vector3);
    
    % Kとsを混同しないように
    K=cat(3,s,g1./g0, g2./g0, g3./g0);



    h=calc_h(K,model);
end