function [x,y] = WGS84ToJTSK(phi, lam)

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
lamb = lambr * 180 / pi;
phib = phibr * 180 / pi;

%Reduction to Ferro
lambr_f = lambr + (17 + 2/3) * pi / 180;

%Gaussian conformal projection: constants values
phi_0 = 49.5 *pi / 180;

alpha = sqrt (1+e2_b*(cos(phi_0))^4/(1-e2_b))
u0 = asin(sin(phi_0)/alpha);
k_n = (tan(phi_0/2 + pi/4))^alpha*((1-sqrt(e2_b)*sin(phi_0))/(1+sqrt(e2_b)*sin(phi_0)))^(alpha*sqrt(e2_b)/2);
k_d = tan(u0/2 + pi/4);
k = k_n / k_d;
R = (a_b * sqrt(1 - e2_b))/(1 - e2_b * sin(phi_0)^2);

%Gaussian conformal projection: ellipsoid -> sphere
c=1/k*(tan(phibr/2 + pi/4)*((1-sqrt(e2_b)*sin(phibr))/(1+sqrt(e2_b)*sin(phibr)))^(sqrt(e2_b)/2))^alpha;
ur = 2*atan(c)-pi/2;
vr = alpha * lambr_f;

%Transformation to the oblique aspect
u = ur*180/pi;
v = vr*180/pi;
uk = 59+42/60+42.6969/3600;
vk = 42+31/60+31.41725/3600;
ukr = uk * pi/180;
vkr = vk * pi/180;
[s,d]=uvTosd(u,v,uk,vk);
sr = s * pi/180;
dr = d * pi/180;

%LCC
s0r = 78.5 * pi /180;
n = sin(s0r);
rho0 = 0.9999*R*cot(s0r);
rho = rho0*((tan(s0r/2 + pi/4))/(tan(sr/2 + pi/4)))^n;
epsilon = n * dr;

%Polar to cartesian
x = rho * cos(epsilon);
y = rho * sin(epsilon);

%Local linear scale
mr = (n * rho)/(R*cos(sr));

%Convergence
xi = asin(cos(ukr) * sin(dr) / cos(ur));
c1 = (epsilon - xi)*180/pi;
c2 = 0.008257*y/1000 + 2.373*y/x;










