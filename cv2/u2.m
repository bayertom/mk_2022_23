clc
clear
hold on 
axis equal

%Draw graticule
u_min = 25;
u_max = 75;
v_min = -10;
v_max = 30;
D_u = 10;
D_v = 10;
d_u = 1;
d_v = 1;
uk = 90;
vk = 0;
R = 6380;
u0 = 0;
proj = @gnom;
[XM,YM,XP,YP] = graticule (u_min, u_max,v_min, v_max, D_u, D_v, d_u, d_v, uk, vk, R,u0, proj)
plot (XM', YM');
plot (XP', YP');

%Draw continents
drawContinents ('continents\eur.txt', 90, 0, 6380, 0, proj)