function [T, a, P, rho] = isa(height)
    [Th, ah, Ph, rhoh] = atmosisa(height);
    [T0, a0, P0, rho0] = atmosisa(0);
    T = Th/T0;
    a = ah/a0;
    P = Ph/P0;
    rho = rhoh/rho0;
% T temperature
% a speed of sound
% p pressure
% rho density
end