function [x,y] = BesselToJTSK(phi, lam)


lambr = lam * pi / 180;
phibr = phi * pi / 180;

%Bessel, definition
a_b = 6377397.1550;
b_b = 6356078.9633;

%Parameters of b
e2_b = (a_b^2 - b_b^2)/a_b^2;
W_b = sqrt(1-e2_b*(sin(phibr))^2);
N_b = a_b/W_b;

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










