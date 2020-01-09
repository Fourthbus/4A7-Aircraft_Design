function pratio = pressu(alt)

global ltable 

alti= ltable(1,1);
n=1;

while alt>alti
    n=n+1;
    alti=ltable(n,1);
    pratio=ltable(n,4);
end

end