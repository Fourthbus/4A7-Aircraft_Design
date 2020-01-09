function T = Temp(alt)

global ltable 

alti= ltable(1,1);
n=1;

while alt>alti
    n=n+1;
    alti=ltable(n,1);
    T=ltable(n,3);
end

end


