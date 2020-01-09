function NOx = NOx_calc (r,T2,M,etac)
global gamma
g = gamma;
gm1 = gamma-1;
T02 = (1+gm1/2*M^2)*T2;
T03 = T02*(1+(r^(gm1/g)-1)/etac);
NOx = .011445*exp(.00676593*T03);
end