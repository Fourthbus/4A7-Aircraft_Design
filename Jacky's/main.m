global rhosl
global psl
global Tsl

k1=0.0125;
k2=0.0446;

range = 9648;
fuel_c = 74*range/12000*1000; %initial guess of carried fuel based on 
mpl = 40; %max payload 
me = 106;
mto = (mpl+me)*1000+fuel_c;

kmremain = range;
s=500;
wto = mto;
w=wto;
alt = 29000;
effc=0.4955;
efftr= 0.9;
LCV=42.7*10^3;
wing_area=315;
distance =0;

total_fuel_burn =0.015*wto;
data=[0,0,0,0,0,0,total_fuel_burn,0];
while kmremain>0
    Veo = (w*9.81/(0.5*rhosl*wing_area))^0.5*((k2/k1)^0.25);
    Ve=Veo;
    TAS = Ve/(rhof(alt)^0.5);
    mach = TAS/((1.4*pressu(alt)*psl*1000/(rhof(alt)*rhosl))^0.5);
    while abs(mach-0.89)>0.002
        alt=alt+100;
        TAS = Ve/(rhof(alt)^0.5);
        mach = TAS/((1.4*pressu(alt)*psl*1000/(rhof(alt)*rhosl))^0.5);
    end
           
    effprop= Pro_eff(1.45,mach,alt);
    ld = 21*1;
    H=effprop*effc*efftr*ld*LCV/9.81;
    fuel_burn = w*(1-1/exp(s/H));
    total_fuel_burn = total_fuel_burn+fuel_burn;
    w=w/exp(s/H);
    kmremain= kmremain-s;
    distance = distance + s;
    data = [data;distance,alt,TAS,mach,effprop,H,fuel_burn,w];
    if kmremain>500
        s=500;
    else
        s=kmremain;
        
    end
    
end

       
   
    
    