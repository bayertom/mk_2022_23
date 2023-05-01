function [s, d] = uvTosd(u, v, uk, vk)

%Degrees to radians
u_r = u * pi/180;
v_r = v * pi/180;
uk_r = uk * pi/180;
vk_r = vk * pi/180;

%Transformed latitude
dv = vk_r - v_r;
s_r = asin(sin(u_r).*sin(uk_r) + cos(u_r) .* cos(uk_r) .* cos(dv));

%Transformed longitude
d_r = atan2 (sin(dv).*cos(u_r),cos(u_r).*sin(uk_r).*cos(dv)-sin(u_r).*cos(uk_r));

s = s_r*180/pi;
d = -d_r*180/pi;