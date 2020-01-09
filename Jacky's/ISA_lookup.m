% ISA look up 
global ltable 
global psl
global rhosl
global Tsl


ft = 0;
psl =101.325;
Tsl =288.15;
rhosl=1.225;
ltable = [0,0,Tsl,psl,rhosl];

while ft<60000 
    
    km = ft/3280.8;
    if km< 11
        T = 288.15 -6.5*km;
        p=((T/Tsl)^5.256);
        rho=((T/Tsl)^4.256);
        
    else
        T=216.65;
        p=((T/Tsl)^5.256)*exp(-0.1577*(km-11));
        rho=((T/Tsl)^4.256)*exp(-0.1577*(km-11));
        
    end
    
    ltable = [ltable; ft, km, T, p, rho];
    
    ft= ft+100;
    
end

  
        
        
        