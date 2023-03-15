function[] = drawGlobeFace(u_min, u_max,v_min, v_max, D_u, D_v, d_u, d_v, uk, vk, R,u0, proj, ub, vb)
hold on
axis equal

%Draw graticule
[XM,YM,XP,YP] = graticule (u_min, u_max,v_min, v_max, D_u, D_v, d_u, d_v, uk, vk, R,u0, proj);
plot (XM', YM', 'k');
plot (XP', YP', 'k');

%Draw continents
drawContinents ('eur.txt', uk, vk, 6380, 0, proj);
drawContinents ('amer.txt', uk, vk, 6380, 0, proj);
drawContinents ('austr.txt', uk, vk, 6380, 0, proj);
drawContinents ('anta.txt', uk, vk, 6380, 0, proj);

%Convert barriers
[sb, db] = uvTosd(ub, vb, uk, vk);

%Project barriers
[xb, yb] = proj(R, sb, db, u0);

%Draw barriers
plot(xb, yb, 'r');