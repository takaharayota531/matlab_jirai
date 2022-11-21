function [x_int,y_int,z_int,h,g,d,nu,er]=antenna_parameters
x_int=0.005;
y_int=0.005;
z_int=0.005;
h = 0.2; % height of antennas
g = 0.19; % gap from caliblation point to アンテナの先端
d = 0.06; % distance between antennas
nu = physconst('Lightspeed'); % light speed
er = 4; % relative permittivity

end
