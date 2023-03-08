function [x,y] = gnom(R, u, v, u0)
ur = u*pi/180;
vr = v*pi/180;

x = R.*tan(pi/2-ur).*cos(vr);
y = R.*tan(pi/2-ur).*sin(vr);

