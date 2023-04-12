clc
clear
format long g

%Pole
uk = 35.33565;
vk = 87.63576;

%Northern and southern points
us = 29.30;
vs = 84;
uj = 28.82;
vj = 80.05;

%Transformed latitutes of both points
[ss,ds]=uvTosd(us,vs,uk,vk);
[sj,dj]=uvTosd(uj,vj,uk,vk);

ss_r = ss * pi / 180;
sj_r = sj * pi / 180;

%Calculate s0
c = ((log10(cos(ss_r)) - log10(cos(sj_r)))/(log10(tan(sj_r/2+pi/4))-(log10(tan(ss_r/2+pi/4)))));
s0_r = asin(c);
s0 = s0_r * 180/pi;

%Calculate rho0
R = 6380;
rho0_n = 2*R*cos(s0_r)*cos(ss_r)*tan(ss_r/2 +pi/4)^c;
rho0_d = c*(cos(s0_r)*tan(s0_r/2 + pi/4)^c+cos(ss_r)*tan(ss_r/2 + pi/4)^c);
rho0 = rho0_n/rho0_d;

%Projection equations
rho_s = rho0*(tan(s0_r/2+pi/4))^c/(tan(ss_r/2+pi/4)^c);
rho_j = rho0*(tan(s0_r/2+pi/4))^c/(tan(sj_r/2+pi/4)^c);

%Local linear scales
mrs = (c * rho_s) / (R * cos(ss_r));
mrj = (c * rho_j) / (R * cos(sj_r));
mr0 = (c * rho0) / (R * cos(s0_r));

nys = mrs - 1;
nyj = mrj - 1;
ny0 = mr0 - 1;










