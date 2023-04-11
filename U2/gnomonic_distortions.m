clc
clear

format long g
hold on


%Symbolic variables
syms R u v

%Gnomonic projection
Y = -R*tan(pi/2-u)*cos(v);
X = R*tan(pi/2-u)*sin(v);

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
mp2 = simplify((fu^2 + gu^2)/R^2);
mr2 = simplify((fv^2 + gv^2)/(R*cos(u))^2);
mp = simplify(sqrt(mp2),'Steps', 40);
mr = simplify(sqrt(mr2),'Steps', 40);
p = 2*(fu * fv + gu * gv)/(R^2*cos(u));

%Area scale
P1 = simplify((gu*fv-gv*fu)/(R^2*cos(u)), 20);
P2 = simplify(mp * mr, 'Steps', 20);

%Maximum angular distortion
d_omega = 2*asin(abs(mp-mr)/(mp+mr));

%Convergence
sigmap = atan2(gu, fu);
c = abs(pi/2 - sigmap);

%Numerical values
Rn = 1;
un = 35.26 * pi / 180;
vn = 90* pi / 180;

%Projection equtation
Xn = double(subs(X,{R, u, v}, {Rn, un, vn}));
Yn = double(subs(Y,{R, u, v}, {Rn, un, vn}));

%Partial derivatives
fun = double(subs(fu,{R, u, v}, {Rn, un, vn}));
fvn = double(subs(fv,{R, u, v}, {Rn, un, vn}));

%Area scale
gun = double(subs(gu,{R, u, v}, {Rn, un, vn}));
gvn = double(subs(gv,{R, u, v}, {Rn, un, vn}));

%Local linear scales
mpn = double(subs(mp,{R, u, v}, {Rn, un, vn}));
mrn = double(subs(mr,{R, u, v}, {Rn, un, vn}));
pn = double(subs(p,{R, u, v}, {Rn, un, vn}));

P1n = double(subs(P1,{R, u, v}, {Rn, un, vn}));
P2n = double(subs(P2,{R, u, v}, {Rn, un, vn}));

%Maximum angular distortion
d_omegan = double(subs(d_omega,{R, u, v}, {Rn, un, vn})) * 180 / pi;

%Convergence
sigmapn = double(subs(sigmap,{R, u, v}, {Rn, un, vn}));
if sigmapn < 0
    sigmapn = sigmapn + 2 * pi;
end

cn = double(subs(c,{R, u, v}, {Rn, un, vn}))* 180 / pi;

%Ellipse of distortions
t = 0: 5* pi / 180 :2*pi;
sc = 0.1;
Xe = mpn * cos(t) * sc;
Ye = mrn * sin(t) * sc;


%Rotation matrix
rm = [cos(sigmapn) -sin(sigmapn); sin(sigmapn) cos(sigmapn)];

%Rotate ellipse
XYe = [Xe; Ye];
XYer = rm*XYe;
Xer = XYer(1,:);
Yer = XYer(2,:);

%Shift to the point
Xer = Xer + Xn;
Yer = Yer + Yn;

plot(Xer, Yer);

%Face1 (E, F, G, H)
D_u = 10;
D_v = 10;
d_u = 1;
d_v = 1;
proj = @gnom;
u0 = 0;
u_min = 30;
u_max = 90;
v_min = -180;
v_max = 180;
uk = 90;
vk = 0;

%Draw graticule
[XM,YM,XP,YP] = graticule (u_min, u_max,v_min, v_max, D_u, D_v, d_u, d_v, uk, vk, Rn, u0, proj);
plot (XM', YM', 'k');
plot (XP', YP', 'k');
axis equal

