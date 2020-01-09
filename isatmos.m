function [T,P,rho,a,Tstag,Pstag,rhostag] = isa(height, M)
    global gamma
    g = gamma;
    gm1 = gamma-1;
    [T, a, P, rho] = atmosisa(height);
%     [T0, a0, P0, rho0] = atmosisa(0);
%     T   = Th/T0;
%     a   = ah/a0;
%     P   = Ph/P0;
%     rho = rhoh/rho0;
    Tstag = T * (1+gm1/2*M^2);
    Pstag = P * (1 + gm1/2 * M^2)^(g/gm1);
    rhostag = rho * (1 + gm1/2 * M^2)^(1/gm1);
    v = M/a;
% T temperature
% a speed of sound
% p pressure
% rho density
end