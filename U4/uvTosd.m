function [s,d] = uvTosd(u, v, uk, vk)
    
    %Degrees to radians
    u = u * pi /180;
    v = v * pi /180;
    uk = uk * pi / 180;
    vk = vk * pi / 180;

    %Longitude difference
    dv = vk - v;
    
    %Latitude, oblique aspect
    s = asin(sin(u) .* sin(uk) + cos(u).* cos(uk) .* cos(dv));
    
    %Longitude, oblique aspect
    d = atan2(sin(dv) .* cos(u), -sin(u).*cos(uk) + cos(u) .* sin(uk) .* cos(dv));
    s = s * 180 / pi;
    d = d * 180 / pi;   
    d=-d;
end

