clc
clear

%Symbolic variables
syms R u v

%Gnomonic projection
X = R*tan(pi/2-u)*cos(v);
Y = R*tan(pi/2-u)*sin(v);

%Partial derivatives
fu = diff(X, u);
fu = simplify(fu, 'Steps', 20);
fv = diff(X, v);
fv = simplify(fv, 'Steps', 20);
gu = diff(Y, u);
gu= simplify(gu, 'Steps', 20);
gv = diff(Y, v);
gv= simplify(gv, 'Steps', 20);

%Scales (symbolic)
mp2 = simplify((fu^2 + gu^2)/R^2)
mr2 = simplify((fv^2 + gv^2)/(R*cos(u))^2)
mp = simplify(sqrt(mp2),'Steps', 40)
mr = simplify(sqrt(mr2),'Steps', 40)
p = 2*(fu * fv + gu * gv)/(R^2*cos(u))

%Area scale
P1 = simplify((gu*fv-gv*fu)/(R^2*cos(u)), 20);
P2 = simplify(mp * mr, 'Steps', 20)

%Maximum angular distorion
d_omega = 2*asin(abs(mp-mr)/(mp+mr));

%Convergence
sigmap = atan2(gu, fu)
c = abs(pi/2 - sigmap)

%Numerical values
