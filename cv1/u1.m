format long g 

%Input coordinates
phi_wgs = 50;
lam_wgs = 15;

[X,Y] = WGS84ToJTSK(phi_wgs, lam_wgs);

