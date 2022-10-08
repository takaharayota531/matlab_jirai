

function t=make_average(s_time)
[Nx,Ny,Nz]=size(s_time);
s_average=sum(s_time,[1 2])/Nx/Ny;
s_changed_time=s_time-s_average;


average_time= mag2db(squeeze(sum(abs(s_changed_time),[1 2]))); % xyの次元をまとめた時の時間領域の特性
 figure;
 plot(average_time);
 xlabel('time[s]');
 ylabel('amplitude[dB]');



t=s_changed_time;
end