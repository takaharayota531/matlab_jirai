function [x,y,z,plot_order]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV)
    E_rH=S_HH*E_iH+S_HV*E_iV;
    E_rV=S_VH*E_iH+S_VV*E_iV;

    J__HH=mean( E_rH.*conj(E_rH),3);
    J__HV=mean(E_rH.*conj(E_rV),3);
    J__VH=mean(E_rV.*conj(E_rH),3);
    J__VV=mean(E_rV.*conj(E_rV),3);    
%     HH=E_rH.*conj(E_rH);
%     HV=E_rH.*conj(E_rV);
%     VH=E_rV.*conj(E_rH);
%     VV=E_rV.*conj(E_rV);   
%     J__HH=HH(:,:,1);
%     J__HV=HV(:,:,1);
%     J__VH=VH(:,:,1);
%     J__VV=VV(:,:,1);   

    g0=J__HH+J__VV;
    g1=J__HH-J__VV;
    g2=J__HV+J__VH;
    g3=(J__HV-J__VH)*1i;


     x=reshape(g1./g0,[],1);
     y=reshape(g2./g0,[],1);
     z=reshape(g3./g0,[],1);
%     x=zeros(size(reshape(g1./g0,[],1)));
%     y=zeros(size(reshape(g2./g0,[],1)));
%     z=zeros(size(reshape(g3./g0,[],1)));
    plot_order=zeros(size(reshape(g1./g0,[],1)));
    tmp_index=1;
    size_length=size(g0,1);
     for i=1:size(g0,1)
         for j=1:size(g0,2)
             plot_order(size_length*(j-1)+i)=tmp_index;
             tmp_index=tmp_index+1;
         end
     end
%  for i=1:size(g0,1)
%         for j=1:size(g0,2)
%             plot_order(size_length*(i-1)+j)=tmp_index;
%             tmp_index=tmp_index+1;
%         end
%     end

end