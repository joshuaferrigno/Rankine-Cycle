% MAE 3311-002: Thermodynamics-II
% Group: 9??
% Members: ...

% Calls the ReheatRepeat function for different numbers of reheat cycles
% and graphs the efficiency over reheat cycles

clear all;
close all;
clc;

f = 50
for i = 1 : f
    Nth(i) = ReheatRepeat(i);
end

plot([1:f],Nth,'ro')
title('Reheat Rankine Cycle Efficiency')
xlabel('Number of reheat cycles')
ylabel('Nth (%)')

saveas(figure(1),'Reheatnum.jpg')