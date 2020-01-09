theta = 6;
eff_turb = 0.9;
eff_comp =0.9;
r = 45;

eff_c = (theta*(1-1/(r^(0.4/1.4)))*eff_turb-(r^(0.4/1.4)-1)/eff_comp)/(theta-1-(r^(0.4/1.4)-1)/eff_comp);


