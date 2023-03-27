clc
clear
hold on 
axis equal

%Input parameters
D_u = 10;
D_v = 10;
d_u = 1;
d_v = 1;
proj = @gnom;
R = 6380;
u0 = 0;

%Face1 (E, F, G, H)
u_min = 30;
u_max = 90;
v_min = -180;
v_max = 180;
uk = 90;
vk = 0;
us = 35.2644
ub = [us, us, us, us, us];
vb = [0, 90, 180, 270, 0];
subplot(2,3,1)
drawGlobeFace(u_min, u_max,v_min, v_max, D_u, D_v, d_u, d_v, uk, vk, R,u0, proj, ub, vb)

%Face2 (A, B, F, E)
u_min = -50;
u_max = 50;
v_min = -20;
v_max = 110;
uk = 0;
vk = 45;
us = 35.2644;
uj = -us;
ub = [uj, uj, us, us, uj];
vb = [0, 90, 90, 0, 0];
subplot(2,3,2)
drawGlobeFace(u_min, u_max,v_min, v_max, D_u, D_v, d_u, d_v, uk, vk, R,u0, proj, ub, vb)

%Face3 (A, B, C, D)
u_min = -90;
u_max = -30;
v_min = -180;
v_max = 180;
uk = -90;
vk = 0;
uj = -35.2644
ub = [uj, uj, uj, uj, uj];
vb = [0, 90, 180, 270, 0];
subplot(2, 3, 3)
drawGlobeFace(u_min, u_max,v_min, v_max, D_u, D_v, d_u, d_v, uk, vk, R,u0, proj, ub, vb)

%Face4 (C, D, G, H)
u_min = -50;
u_max = 50;
v_min = 170;
v_max = 280;
uk = 0;
vk = 225;
us = 35.2644;
uj = -us;
ub = [uj, uj, us, us, uj];
vb = [180, 270, 270, 180, 180];
subplot(2,3,4)
drawGlobeFace(u_min, u_max,v_min, v_max, D_u, D_v, d_u, d_v, uk, vk, R,u0, proj, ub, vb)

