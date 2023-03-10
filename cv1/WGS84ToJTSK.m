function [X,Y] = WGS84ToJTSK(phi_wgs, lam_wgs)

%Degrees to rad
phir_wgs= pi/180*phi_wgs;
lamr_wgs= pi/180*lam_wgs;

%WGS84, definition
a_wgs = 6378137;
b_wgs = 6356752.3142;

%Parameters of WGS84
e2_wgs = (a_wgs^2 - b_wgs^2)/a_wgs^2;
W_wgs = sqrt(1-e2_wgs*(sin(phir_wgs))^2);
N_wgs = a_wgs/W_wgs;

%Cartesian coordinates
X_wgs=N_wgs*cos(phir_wgs)*cos(lamr_wgs);
Y_wgs=N_wgs*cos(phir_wgs)*sin(lamr_wgs);
Z_wgs=N_wgs*sin(phir_wgs)*(1-e2_wgs);

%Parameters of 3D similarity transformation
omx = 4.9984 / 3600 * pi/180;
omy = 1.5867 / 3600 * pi/180;
omz = 5.2611 / 3600 * pi/180;
m = 1 - 3.5623e-6;
dx = -570.8285;
dy = -85.6769;
dz = -462.8420;

%Matrix of rotation
R = [1 omz -omy;-omz 1 omx;omy -omx 1];

%Helmert 3D transformation
XYZ_b = m*R*[X_wgs;Y_wgs;Z_wgs]+[dx;dy;dz];

X_b = XYZ_b(1,:);
Y_b = XYZ_b(2,:);
Z_b = XYZ_b(3,:);

%Bessel ellipsoid, definition
a_b = 6377397.1550;
b_b = 6356078.9633;

%Parameters of Bessel ellipsoid
e2_b = (a_b^2 - b_b^2)/a_b^2;

%Latitude, longitude Bessel ellipsoid
lamr_b = atan(Y_b/X_b);
phir_b = atan(Z_b/((1 - e2_b)*sqrt(X_b^2 + Y_b^2));

W_b = sqrt(1-e2_b*(sin(phir_b))^2);
N_b = a_b/W_b;








