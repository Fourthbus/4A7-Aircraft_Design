% cycle efficiency
function [etacyc,etap] = turbine(r,t,etac,etat,FPR,etaf,M,Pa)
% t = theta
global gamma
g = gamma;
gm1 = gamma-1;
etacyc = (t*(1-r^(-gm1/g))*etat - (r^(gm1/g)-1)/etac) /...
    (t-1-(r^(gm1/g)-1)/etac);
%
P02 = Pa * (1 + gm1/2 * M^2)^(g/gm1);
Mj = sqrt( 2/gm1 * ((FPR*P02/Pa)^(gm1/g)-1) ); % jet mach number
rtj = (1+.5*gm1*M^2)/(1+.5*gm1*Mj^2) * FPR^(gm1/g/etaf); % Tj/Ta
etap = 2/(1+ Mj/M * sqrt(rtj));
end