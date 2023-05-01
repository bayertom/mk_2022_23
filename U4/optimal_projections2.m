clc
clear
hold on
axis equal

%Input parameters
R = 6380;
u0 = 0;
u_min = -90;
u_max = 90;
v_min = -180;
v_max = 180;
uk = 90;
vk = 0;
D_u = 10;
D_v = 10;
d_u = 1;
d_v = 1;

%Create meshgrid
[ug, vg] = meshgrid(u_min : d_u : u_max, v_min : d_v : v_max);
ugr = ug * pi / 180;
vgr = vg * pi / 180;
[xg, yg] = sinu(R, ug, vg, u0);

%Distortions
mp2 = 1 + (vgr .* sin(ugr)).^2;
mr2 = 1;
p = -2 * vgr .* sin(ugr);
A1 = 0.5 * atan(-2./(vgr.*sin(ugr)));
A2 = A1 + pi/2;

%Tissot ellipse
a2 =mp2.*cos(A1).^2 + mr2.*sin(A1).^2 + p.*sin(A1).*cos(A1);
b2 =mp2.*cos(A2).^2 + mr2.*sin(A2).^2 + p.*sin(A2).*cos(A2);
a = sqrt(a2);
b = sqrt(b2);

%Airy + complex criteria
h2a = ((a-1).^2 + (b-1).^2)/2;
h2c = (abs(a-1)+abs(b-1))/2 + a./b -1;

%Global criteria (non-weighted)
H2a = mean(h2a(:));
H2c = mean(h2c(:));

%Create graticule
proj = @sinu;
[XM,YM,XP,YP] = graticule(u_min, u_max,v_min, v_max, D_u, D_v, d_u, d_v, uk, vk, R, u0, proj);
plot (XM', YM', 'k');
plot (XP', YP', 'k');

%Load continents
uvc = load('amer.txt');
[XC, YC] = sinu(R, uvc(:, 1), uvc(:, 2));
plot (XC, YC, 'b', 'LineWidth', 2);

%Variable map scale
M = 100000000;
Muv = M./a;

%Draw contour lines
[C, h] = contour(xg, yg, Muv, [20000000:10000000:100000000], 'LineColor', 'r')
%[C2, h2] = contour(xg, yg, dist, [-1:0.5:10], 'LineColor', 'r', 'LineWidth', 2);
clabel(C, h, 'Color', 'r');







