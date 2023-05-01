function [x,y] = sinu(R, u, v, u0)
%Mercator-Sanson(sinusoidal)
ur = u * pi / 180;
vr = v * pi / 180;

x = R*vr.*cos(ur);
y = R*ur;



