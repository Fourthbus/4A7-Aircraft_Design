function eff = Pro_eff(FPR,M,fl)
global psl
%this function calculates propulsive efficiency given flight parameters
p= pressu(fl)*psl;

p02= p*(1+(0.4/2)*M^2)^(1.4/0.4);

Mj2 = 2/0.4*((FPR*p02/p)^(0.4/1.4)-1);

Tratio= ((1+0.5*0.4*M^2)/(1+0.5*0.4*Mj2))*FPR^(0.4/1.4/0.92);

eff = 2*((1+Mj2^0.5/M*(Tratio)^0.5)^(-1));
