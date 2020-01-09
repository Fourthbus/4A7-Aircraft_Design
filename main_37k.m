clear all global
global gamma we wmp wmto np hci vc ldc ...
    c1 c2 K1 K2 EI LCV

% constants declearing
gamma = 1.4;

%
% Ryanair 738 data
we   = 41413; % empty weight kg
wmp  = 20276; % maximum payload kg
wmto = 78245; % maximum take off kg
np   = 189  ; % 189 passenger Ryanair 738
smp  = 3740 ; % 2000 nm in km
hci  = 37000; % initial cruise height ft.
Mc   = 0.785; % cruise mach number 
vc   = 233  ; % cruise air speed m/s
ldc  = 17   ; % L/D at cruise
Sw   = 125  ; % wing area m^2
%
% Engine parameters (use CFM56-7B24 if available)
OPR   = 32.7; % overall PR
theta = 6   ; % turbine inlet T ratio
etac  = 0.9 ;
etat  = 0.9 ; % isentropic effi. turbine
FPR   = 1.45; % fan PR
etaf  = 0.92; % effi. fan
etatr = 0.9 ; % effi. transfer
%
% modelling constants
k  = 0.016; % Breguet modification
c1 = 0.3  ; % weight correction
c2 = 1.0  ;
K1 = 0.016; % parabolic rule constants estimated by 17 L/D
K2 = 0.052;
%
EI  = 3088  ; % ei of CO2 3088 gCO2/kgfuel
LCV = 42.7e6; % fuel LCV J/kg
%
% set fly conditions of interest
M = Mc; % fly Mach
h = convlength(hci,'ft','m'); % initial mach
wp = np * 100 * 1.05; % payload
range = 1400;

%
% initial conditions
[T,P,rho,~] = isatmos(h,M); % ISA conditions
[etacyc,etap] = turbine(OPR,theta,etac,etat,FPR,etaf,M,P); % turbine
eta = etap * etacyc * etatr;
v=1;
LoD = LoD_calc(v); % L/D at current stage
H   = eta * LoD * LCV / 9.81 / 1000; % range parameter
wf0 = (wp+we)*(1+k-exp(-range/H))/(exp(-range/H)-k)+1600; % fuel mass calculation 1600 reserve
wto = wf0+wp+we;

% eta0 = etaprop * etath
% sfc  = 1/eth0 * v/LCV

% wf = wf_calc (wto);
% co2pp = co2pp_calc(wf);
ds = 50;
s = 200;
wf = wf0;
data = [0,0,0,0,0,0];
% main fly condition calculation loop
FB = k*wto;
while 1
    if s > range
        s = range;
    end
    wf = wf0-FB; % fuel burnt
    m  = wp + we + wf; % current total weight
    wl = m*9.81/Sw   ; % current wing loading
    [~,~,rhosl] = isatmos(h,M); % sea level reference
    Veo = (2*wl/rhosl)^.5 * (K2/K1)^(0.25); % optimised Ve
    Ve  = convvel(450,'kts','m/s'); % equvalent air speed
    v = Ve/Veo;
    [T,P,rho,a] = isatmos(h,M);
    Vt  = Ve * (rho/rhosl)^(-.5); % true air speed
    M   = Vt/a; % mach number
    
    if M > 0.825 % excluede case when supersonic drag buggered
        M
    end
    [etacyc,etap] = turbine(OPR,theta,etac,etat,FPR,etaf,M,P); % turbine
    eta = etap * etacyc * etatr; % overall engine effi.
    LoD = LoD_calc(v); % L/D at current stage
    H   = eta * LoD * LCV / 9.81 / 1000; % range parameter
    FB  = wto*(1+k-exp(-s/H)); % current fuel left
    NOx = NOx_calc (OPR,T,M,etac);
    data = [data;s,convlength(h,'m','ft'),FB,M,convvel(Vt,'m/s','kts'),NOx];
    if s == range
        break;
    else
        s = s+ds;
    end
end

figure(1);
plot(data(:,1),data(:,2),'ko-');
xlabel('Distance [km]','Interpreter','latex')
ylabel('Height [ft.]','Interpreter','latex')

figure(2);
plot(data(:,1),data(:,3),'ko-');
xlabel('Distance [km]','Interpreter','latex')
ylabel('Fuel burnt [kg]','Interpreter','latex')
ylim([0,5000]);

figure(3);
plot(data(:,1),data(:,4),'ko-');
xlabel('Distance [km]','Interpreter','latex')
ylabel('Mach number','Interpreter','latex')