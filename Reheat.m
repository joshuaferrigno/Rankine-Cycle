% MAE 3311-002: Thermodynamics-II
% Group: 9??
% Members: ...

% Reheat Rankine Cycle - Input # of reheat cycles, the reheat pressure is
% evenly distributed between the top and bottom pressure. For example if
% reheat# = 3, reheat pressure(1) = ((p2-p1)/reheat#)*1, reheat pressure(2)
% = ((p2-p1)/reheat#)*2, etc. Outputs the T-S diagram

clear all;
close all;
clc;
format long

% Example 10-4:
p1 = 10; % kpa
p2 = 15e3; % kpa
tCeiling = 600; % *C
reheatNum = 20; % # of Reheat Cycles

for i = 1 : reheatNum
    inc = (p2-p1)/(reheatNum+1);
    pReheat(i) = inc*i;
end

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


for i = 0 : 2 : 2*reheatNum -2     
    h(i+4) = XSteam('h_ps',P2B(pReheat(reheatNum - i*.5)),s(3 + i));
    h(i+5) = XSteam('h_pT',P2B(pReheat(reheatNum - i*.5)),tCeiling);
    s(i+4) = XSteam('s_ph',P2B(pReheat(reheatNum - i*.5)),h(i+4));
    s(i+5) = XSteam('s_pT',P2B(pReheat(reheatNum - i*.5)),tCeiling);
    t(i+4) = XSteam('T_ph',P2B(pReheat(reheatNum - i*.5)),h(i+4));
    t(i+5) = tCeiling;
end
h(2*reheatNum+4) = XSteam('h_ps',P2B(p1),s(2*reheatNum+3));
t(2*reheatNum+4) = XSteam('T_ps',P2B(p1),s(2*reheatNum+3));
s(2*reheatNum+4) = s(2*reheatNum+3);
for i = 0 : reheatNum 
    qin(i+1) = h(3 + 2*i) - h(2 + 2*i);
end
Qin = sum(qin);
    
qout = h(reheatNum*2+4) - h(1);

nTh = (1 - (qout/Qin))*100;
fprintf('The efficiency of a basic Rankine Cycle = %f%%\n',nTh)

plot(s,t,'ro')
title('T-S diagram of reheat')
xlabel('Entropy (kj/kg*k)')
ylabel('Temperature (C)')