function fuel_pl_dist = f_pd_calc(we,wp,s,H)
% fuel per payload distance: slide 55
k = 0.015 % emperical parameter
fuel_pl_dist = 1/s (1+we/wp) * (1-exp(-s/H)+k)/(exp(-s/H)-k)
end