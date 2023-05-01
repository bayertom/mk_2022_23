clc
clear
format long g
axis equal

%cartographic pole
uk = 28.1419
vk = 84.2080

%Southern point
uj = 28.9584
vj = 79.8961

%Transform to oblique aspect
[sj,dj] = uvTosd(uj,vj,uk,vk);

%Reduction
psij = 90 - sj;
psijr = psij* pi/180;

%Multiplicative constant
mju= 2*(cos(psijr/2))^2/(1+(cos(psijr/2))^2);

%Psi0: true parallel laatitude
psi0r = 2*acos(sqrt(mju));
s0r = pi/2-psi0r;
s0 = 180 / pi * s0r;

%Local linear scales
mrj = (cos(psi0r/2)/cos(psijr/2))^2;
mrs = (cos(psi0r/2)/cos(0))^2;
mr0 = (cos(psi0r/2)/cos(psi0r/2))^2;

nys = mrs - 1;
nyj = mrj - 1;
ny0 = mr0 - 1;

%Load Nepali
uv = load("nepal.txt");
u = uv(: , 1);
v = uv(: , 2);

%Convert u,v to s,d
[s,d] = uvTosd(u,v,uk,vk);

%Image in stereographic projection
R = 6380;
[xn,yn] = stereo(R,s,d,s0); 

%Draw continents
hold on
plot(xn, yn,'b', 'LineWidth', 2);

%Create graticule
u_min = 25;
u_max = 35;
v_min = 75;
v_max = 90;
D_u = 1;
D_v = 1;
d_u = 0.1;
d_v = 0.1;
proj = @stereo;

[XM,YM,XP,YP] = graticule (u_min, u_max,v_min, v_max, D_u, D_v, d_u, d_v, uk, vk, R, s0, proj);

%Draw
plot (XM', YM', 'k');
plot (XP', YP', 'k');

%Create meshgrid
[ug, vg] = meshgrid(u_min : d_u : u_max, v_min : d_v : v_max);

%Convert ug,vg to sg,dg
[sg,dg] = uvTosd(ug,vg,uk,vk);

%Stereographic projection
[xg, yg] = stereo(R, sg, dg, s0);

%Reduction
psig = 90-sg;
psigr = psig*pi/180;

%Local linear scales
mr = (cos(psi0r/2)./cos(psigr/2)).^2;

%Distortions
dist = (mr - 1)*1000;

%Draw contour lines
[C, h] = contour(xg, yg, dist, [-1:0.1:10], 'LineColor', 'r')
[C2, h2] = contour(xg, yg, dist, [-1:0.5:10], 'LineColor', 'r', 'LineWidth', 2);
clabel(C2, h2, 'Color', 'r');










