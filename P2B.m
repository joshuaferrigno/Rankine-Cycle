% Conversion from kpa to bar because XSteam reads bar
function B = P2B(P)
B = P/100;
end