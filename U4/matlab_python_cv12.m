clc
clear
format long g
axis equal
hold on

%Set Python environment
pyenv(Version="C:\Program Files\Python310\python.exe");

% Define extent
u_min = -80;
u_max = 80;
v_min = -180;
v_max = 180;

%Define steps
Du = 10;
Dv = 10;
dv = Dv/10;
du = Du/10;

%Projection parameters
R = 6380;
proj = 'wintri';
uk = 90;
vk = 0;
u0 = 0;

%Grid
[ug, vg] = meshgrid(u_min:Du:u_max, v_min:Dv:v_max);
xyg = py.mk.project(py.numpy.array(ug), py.numpy.array(vg), proj, R);
XG = double(xyg{1});
YG = double(xyg{2});
a = double(xyg{3});
b = double(xyg{4});

%Create graticule
[XM,YM,XP,YP] = graticuleproj(u_min, u_max,v_min, v_max, Du, Dv, du, dv, uk, vk, R, u0, proj);
plot (XM', YM', 'k');
plot (XP', YP', 'k');

%Continents
uvc = load('amer.txt')
xyc = py.mk.project(uvc(:, 1), uvc(:, 2), 'sinu', R);
XC = double(xyc{1});
YC = double(xyc{2});
plot (XC, YC, 'b', 'LineWidth', 2);

%Variable map scale
M = 100000000;
Muv = M./a;

%Draw contour lines
[C, h] = contour(XG, YG, Muv, [20000000:10000000:100000000], 'LineColor', 'r', 'LineWidth', 2)
clabel(C, h, 'Color', 'r', 'labelspacing', 1000);






