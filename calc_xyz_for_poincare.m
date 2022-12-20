%ストークスベクトルを球状にプロットするために正規化する
function [x,y,z]=calc_xyz_for_poincare(g0,g1,g2,g3)
    x=g1./g0;
    y=g2./g0;
    z=g3./g0;



end