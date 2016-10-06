function [ val ] = ComputeKDE( x, data, h )
    val = 0;
    for idx = 1 : length(data)
        val = val + PointK(x, data(idx), h);
    end
    val = val/(h*length(data));
end

function [kx] = PointK(x, xk, h)
    x1 = (x - xk)/h;
    kx = ((2*pi)^(-1/2))*exp(-1/2*((x1)^2));
end

