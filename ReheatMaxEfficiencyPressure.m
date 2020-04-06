% MAE 3311-002: Thermodynamics-II
% Group: 9??
% Members: ...

% Reheat Rankine Cycle - Finds the best reheat pressure for a single reheat
% rankine cycle.

clear all;
close all;
clc;
format long

% Basic simulation of a rankine cycle power plant between 75 kpa, and 3 Mpa.
% Example 10-4:
p1 = 75; % kpa
p2 = 15e3; % kpa
tCeiling = 600; % *C

nTh(1:15e3/100) = 0;

for pReheat = 100 : 100 : 15e3

    h(1) = XSteam('hL_p',P2B(p1));
    v(1) = XSteam('vL_p',P2B(p1));
    s(1) = XSteam('s_ph',P2B(p1),h(1));
    t(1) = XSteam('T_ph',P2B(p1),h(1));

    wPump = v(1)*(p2-p1);
    h(2) = h(1) + wPump;
    t(2) = XSteam('T_ph',P2B(p2),h(2));
    s(2) = XSteam('s_ph',P2B(p2),h(2));

    h(3) = XSteam('h_pT',P2B(p2),tCeiling);
    s(3) = XSteam('s_pT',P2B(p2),tCeiling);
    t(3) = tCeiling;


    h(4) = XSteam('h_ps',P2B(pReheat),s(3));
    h(5) = XSteam('h_pT',P2B(pReheat),tCeiling);
    s(4) = XSteam('s_ph',P2B(pReheat),h(4));
    s(5) = XSteam('s_pT',P2B(pReheat),tCeiling);
    t(4) = XSteam('T_ph',P2B(pReheat),h(4));
    t(5) = tCeiling;

    h(6) = XSteam('h_ps',P2B(p1),s(5));
    t(6) = XSteam('T_ps',P2B(p1),s(5));
    s(6) = s(5);

    qin = (h(3) - h(2)) + (h(5) - h(4));

    qout = h(6) - h(1);

    nTh(pReheat/100) = (1 - (qout/qin))*100;
end

plot([100 : 100 : 15e3],nTh,'ro')
title('Efficiency of a Single Reheat at Differing Pressure')
xlabel('Reheat Pressure (kpa)')
ylabel('Efficiency (%)')

% saveas(figure(1),'ReheatP.jpg')