function [h,K]= ...
    CS_optimization_calc_h(s,model,p,WHEN,lambda)%散乱画像、ウィンドウサイズ、モデルサイズ
  

  
   FREQ_POINT=size(s,3)/4
    IF_NORMALIZATION=false

    S_HH=s(:,:,1:FREQ_POINT);
    S_HV=s(:,:,FREQ_POINT+1:2*FREQ_POINT);
    S_VH=s(:,:,2*FREQ_POINT+1:3*FREQ_POINT);
    S_VV=s(:,:,3*FREQ_POINT+1:4*FREQ_POINT);

    % データの比率を一緒にしている
    [K,s]=create_feature_vector_full_polarimetry(s,0,1,FREQ_POINT,IF_NORMALIZATION,WHEN,lambda);
  K_only_feature_vector=K(:,:,4*FREQ_POINT+1:end);
%     K_only_feature_vector=K(:,:,4*FREQ_POINT+1:end);
%     K_only_S=K(:,:,1:4*FREQ_POINT);
 K_only_S=K(:,:,1:4*FREQ_POINT);
    h_only_feature_vector=calc_h(K_only_feature_vector,model);
    h_only_S=calc_h(K_only_S,model);
    h=calc_h(K,model);

    h_HH=calc_h(S_HH,model);
    h_HV=calc_h(S_HV,model);
    h_VH=calc_h(S_VH,model);
    h_VV=calc_h(S_VV,model);

    


%     figure(1)
%     imagesc(h_HH)
%     title("散乱行列SHH")
%     figure(2)
%     imagesc(h_HV)
%     title("散乱行列SHV")
%     figure(3)
%     imagesc(h_VH)
%     title("散乱行列SVH")
%     figure(4)
%     imagesc(h_VV)
%      title("散乱行列SVV")


%     figure(7)
%     imagesc(h)
%    title("特徴量K")
%     figure(8)
%     imagesc(h_only_feature_vector)
%      title("特徴量行列S'")
%     figure(9)
%     imagesc(h_only_S)
%     title("散乱行列S")


    s_dash1= K(:,:,4*FREQ_POINT+1:5*FREQ_POINT);
    s_dash2= K(:,:,5*FREQ_POINT+1:6*FREQ_POINT);
    s_dash3= K(:,:,6*FREQ_POINT+1:7*FREQ_POINT);
    s_dash4= K(:,:,7*FREQ_POINT+1:8*FREQ_POINT);
    K1=calc_h(s_dash1,model);
K2=calc_h(s_dash2,model);
K3=calc_h(s_dash3,model);
K4=calc_h(s_dash4,model);
%     figure(10)
%     imagesc(K1)
%     title("S'HH")
%     figure(11)
%     imagesc(K2)
%     title("S'HV")
%     figure(12)
%     imagesc(K3)
%     title("S'VH")
%     figure(13)
%     imagesc(K4)
%      title("S'VV")



     s_reflection_symmetry=ReflectionSymmetry(s);
     K_ref=calc_h(s_reflection_symmetry,model);
     figure(15)
     imagesc(K_ref)
     title('reflection symmetry')
      s_reflection_symmetry1=abs((S_VV).*conj(S_HV));
     K_ref1=calc_h(s_reflection_symmetry1,model);
     figure(16)
     imagesc(K_ref1)
     title('reflection symmetry1')

       [s_reflection_symmetry,amp,phase]=calc_reflection_symmetry(s);
    k_reflection_symmetry=calc_h(s_reflection_symmetry,model);
    figure(17)
     imagesc(k_reflection_symmetry)
     title('LL-RR phase')

    s_reflection_symmetry_abs=calc_reflection_symmetry_abs(s);
    k_reflection_symmetry_abs=calc_h(s_reflection_symmetry_abs,model);
    figure(18)
     imagesc(k_reflection_symmetry_abs)
     title(['LL-RR'])

end

function s_reflection_symmetry= ReflectionSymmetry(S)
FREQ_POINT=size(S,3)/4;
  S_HH=S(:,:,1:FREQ_POINT);
  S_HV=S(:,:,FREQ_POINT+1:2*FREQ_POINT);
  S_VH=S(:,:,2*FREQ_POINT+1:3*FREQ_POINT);
  S_VV=S(:,:,3*FREQ_POINT+1:4*FREQ_POINT);
  s_reflection_symmetry=abs((S_VV).*conj(S_VH));
  % s_reflection_symmetry1=abs((S_VV).*conj(S_HV));
  
end