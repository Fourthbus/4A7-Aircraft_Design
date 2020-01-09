function densityratio = rhof(alt)

global ltable 

alti= ltable(1,1);
n=1;

while alt>alti
    n=n+1;
    alti=ltable(n,1);
    densityratio=ltable(n,5);
end

end