clc
clear
format long g

%Initial point
phi1 = 50;
lam1 = 15;

phi2 = 49;
lam2 = 17;

%Convert to JTSK
[x1,y1] = WGS84ToJTSK(phi1, lam1)
[x2,y2] = WGS84ToJTSK(phi2, lam2)

d1 = ((x2-x1)^2+(y2-y1)^2)^0.5;

%Convert to JTSK
[x3,y3] = BesselToJTSK(phi1, lam1)
[x4,y4] = BesselToJTSK(phi2, lam2)

d2 = ((x4-x3)^2+(y4-y3)^2)^0.5;
