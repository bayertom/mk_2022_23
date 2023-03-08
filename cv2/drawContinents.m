function [] = drawContinents (file, uk, vk, R, u0, proj)

%Load continents
U = load (file);
uc = U(:, 1);
vc = U(:, 2);

%Convert to oblique aspect
[sc, dc] = uvTosd(uc, vc, uk, vk);

%Find sc < s_min
idx = find(sc < 5);
sc(idx) = [];
dc(idx) = [];

%Project continents
[xc, yc] = proj(R, sc, dc, u0);

%Draw continents
plot(xc, yc);
