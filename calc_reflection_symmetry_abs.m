function result=calc_reflection_symmetry_abs(s)
    FREQ_POINT=size(s,3)/4;
    % IF_NORMALIZATION=false

    S_HH=s(:,:,1:FREQ_POINT);
    S_HV=s(:,:,FREQ_POINT+1:2*FREQ_POINT);
    S_VH=s(:,:,2*FREQ_POINT+1:3*FREQ_POINT);
    S_VV=s(:,:,3*FREQ_POINT+1:4*FREQ_POINT);

%     S_HV_re=(S_HV+S_VH)/2;
%     S_HV_re=S_VH;
    S_HV_re=S_HV;

    numerator=4*abs(S_HV_re).^2-abs(S_HH-S_VV).^2-4i*real(conj(S_HV_re).*(S_HH-S_VV));
    denominator=abs(S_HH-S_VV+2i*S_HV_re).*abs(S_HH-S_VV-2i*S_HV_re);
  
%     result=abs(numerator)./denominator;
 result=abs(numerator);
% result=(numerator./denominator);
end