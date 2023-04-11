function [X,Y] = WGS84ToJTSK(phi, lam)

%degrees to rad
phir= pi/180*phi;
lamr= pi/180*lam;

%WGS84, definition
a_wgs = 6378137;
b_wgs = 6356752.3142;

%Parameters of WGS84
e2_wgs = (a_wgs^2 - b_wgs^2)/a_wgs^2;
W_wgs = sqrt(1-e2_wgs*(sin(phir))^2);
N_wgs = a_wgs/W_wgs;

%Cartesian coords
X_wgs=N_wgs*cos(phir)*cos(lamr);
Y_wgs=N_wgs*cos(phir)*sin(lamr);
Z_wgs=N_wgs*sin(phir)*(1-e2_wgs);

%Parameters of 3D similarity transformation
omx = 4.9984 / 3600 * pi/180;
omy = 1.5867 / 3600 * pi/180;
omz = 5.2611 / 3600 * pi/180;
m = 1 - 3.5623e-6;
dx = -570.8285;
dy = -85.6769;
dz = -462.8420;

%matrix of rotation
R = [1 omz -omy;-omz 1 omx;omy -omx 1];

%Helmert 3D transformation
XYZ_b = m*R*[X_wgs;Y_wgs;Z_wgs]+[dx;dy;dz];

X_b = XYZ_b(1,:);
Y_b = XYZ_b(2,:);
Z_b = XYZ_b(3,:);

%Bessel, definition
a_b = 6377397.1550;
b_b = 6356078.9633;

%Parameters of b
e2_b = (a_b^2 - b_b^2)/a_b^2;
W_b = sqrt(1-e2_b*(sin(phir))^2);
N_b = a_b/W_b;

%longitude bessel el
lambr = atan2(Y_b, X_b);
phibr = atan2(Z_b, (1 - e2_b)*sqrt(X_b^2 + Y_b^2));

%Reduction to Ferro
lambr_f = lambr + (17 + 2/3) * pi / 180;

%Gauss conformal projection: constants values
phi_0 = 49.5 *pi / 180;

alpha = sqrt (1+e2_b*(cos(phi_0))^4/(1-e2_b))
u0 = asin(sin(phi_0)/alpha);
k_n = (tan(phi_0/2 + pi/4))^alpha*((1-sqrt(e2_b)*sin(phi_0))/(1+sqrt(e2_b)*sin(phi_0)))^alpha*sqrt(e2_b)/2
k_d = tan(u0/2 + pi/4);
k = k_n / k_d;

R = (a_b * sqrt(1 - e2_b))/(1 - e2_b * sin(phi_0)^2);

%Gauss conformal projection: ellipsoid -> sphere

