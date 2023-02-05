function [result,amp,phase]=calc_reflection_symmetry(s)
    FREQ_POINT=size(s,3)/4
    % IF_NORMALIZATION=false

    S_HH=s(:,:,1:FREQ_POINT);
    S_HV=s(:,:,FREQ_POINT+1:2*FREQ_POINT);
    S_VH=s(:,:,2*FREQ_POINT+1:3*FREQ_POINT);
    S_VV=s(:,:,3*FREQ_POINT+1:4*FREQ_POINT);

%     S_HV_re=(S_HV+S_VH)/2;
 S_HV_re=S_VH;
% S_HV_re=S_HV;
    % phase test done 
    phase=4*real(conj(S_HV_re).*(S_HH-S_VV));
    % amp test done
    amp=(S_HH-S_VV).*conj((S_HH-S_VV)) - 4*(S_HV_re).*conj(S_HV_re);
    x=phase./amp;

    result=x./sqrt(1+x.^2);
% ans=amp;
% ans=phase;
end