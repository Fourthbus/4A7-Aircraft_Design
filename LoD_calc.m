function [LoD] = LoD_calc(v),
global K1 K2
betao = 2 * sqrt(K1*K2);
beta = .5 * betao * (v^2 + 1/v^2);
LoD = 1/beta;
end