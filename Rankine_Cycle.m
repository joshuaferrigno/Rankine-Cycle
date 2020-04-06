% MAE 3311-002: Thermodynamics-II
% Group: 9??
% Members: ...

% Note!: Calculations breakdown when the boiler pressure > 100000 kpa,
% when condenser pressure < 0 kpa, and when boiler temperature > 2000 C (due to
% XSteam tables not going above 2000 C).

clear all;
close all;
clc;
hold on


% Basic simulation of a rankine cycle power plant between 75 kpa, and 3 Mpa.
% Example 10-1:
p1 = 75; % kpa
p2 = 3e3; % kpa

h1 = 384.44;
h2 = 387.47;
h3 = 3116.1;
h4 = 2403.0;

qout = h4-h1;
qin = h3-h2;

nTh = (1 - (qout/qin))*100;
fprintf('The efficiency of a basic Rankine Cycle = %f%%\n',nTh)

% Increasing Boiler Temperature
figure(1)
title('Increasing Boiler Temperature')
xlabel('Boiler Temperature (C)')
ylabel('Thermal Efficiency (%)')
boilerTMax = 2000-360;
for i = 0 : 10 : boilerTMax
    boilerT = 350 + i;
    h3 = XSteam('h_pt',P2B(p2),boilerT);
    s3 = XSteam('s_pT',P2B(p2),boilerT);
    h4 = XSteam('h_ps',P2B(p1),s3);
    qout = h4-h1;
    qin = h3-h2;

    nTh = (1 - (qout/qin))*100;
    plot(boilerT,nTh,'r*')
    drawnow
end
fprintf('The efficiency of a Rankine Cycle with increased boiler temperature = %f%%\n',nTh)

% Decreasing the Condenser Pressure
figure(2)
hold on
title('Decreasing Condenser Pressure')
xlabel('Condenser Pressure (kpa)')
ylabel('Thermal Efficiency (%)')

for i = 0 : p1 - 1
    condenserP = p1 - i;
% condenserP = 70
    h1 = XSteam('hL_p',P2B(condenserP));
    v1 = XSteam('vL_p',P2B(condenserP));
    wPump = v1*(p2-condenserP);
    h2 = h1 + wPump;
    s3 = XSteam('s_pT',P2B(p2),350);
    h3 = XSteam('h_pT',P2B(condenserP),350);
    h4 = XSteam('h_ps',P2B(condenserP),s3);
    qout = h4-h1;
    qin = h3-h2;
    
    nTh = (1 - (qout/qin))*100;
    plot(condenserP,nTh,'b*')
    drawnow
    set ( gca, 'xdir', 'reverse' )
end
fprintf('The efficiency of a Rankine Cycle with decreased conderser pressure = %f%%\n',nTh)

% Increasing the Boiler Pressure
figure(3)
hold on
title('Increasing Boiler Pressure')
xlabel('Boiler Pressure (Mpa)')
ylabel('Thermal Efficiency (%)')

pMax = 100000 - 3000;
for i = 0 : 1000 : pMax - 1000
    boilerP = p2 + i;
    h1 = XSteam('hL_p',P2B(p1));
    v1 = XSteam('vL_p',P2B(p1));
    s1 = XSteam('sL_p',P2B(p1));
    wPump = v1*(boilerP-p1);
    h2 = XSteam('h_ps',P2B(boilerP),s1);
    s3 = XSteam('s_pT',P2B(boilerP),600);
    h3 = XSteam('h_pT',P2B(boilerP),600);
    h4 = XSteam('h_ps',P2B(p1),s3);
    qout = h4-h1;
    qin = h3-h2;

    nTh = (1 - (qout/qin))*100;
    plot(boilerP/1000,nTh,'m*')
    drawnow
end
fprintf('The efficiency of a Rankine Cycle with increased boiler pressure = %f%%\n',nTh)

saveas(figure(1),'BoilerT.jpg')
saveas(figure(2),'CondenserT.jpg')
saveas(figure(3),'BoilerP.jpg')