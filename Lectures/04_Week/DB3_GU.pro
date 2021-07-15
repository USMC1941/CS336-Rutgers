flights(f1, lax, hnl, 2551, 1100, 1830, 300).
flights(f2, lax, hnl, 2551, 0800, 1400, 450).
flights(f3, lax, ord, 2028, 1500, 1900, 200).
flights(f4, lax, ord, 2028, 1000, 1530, 170).

aircraft(a1, boeing747, 3000).
aircraft(a2, airbusA321, 900).
aircraft(a3, boeing777, 2000).

certified(e1, a1).
certified(e1, a3). 
certified(e2, a1). 
certified(e2, a2).
certified(e2, a3).
certified(e3, a2).
certified(e4, a2).
certified(e4, a3).

employees(e1, albert, 120000).
employees(e2, becky, 200000).
employees(e3, calvin, 30000).
employees(e4, david, 70000).

% Find the names of aircraft such that all pilots certified to operate them have salaries more than $80,000.
% This finds aircraft that has at least one pilot whose salary is over $80,000
q1wrong(AName):- aircraft(AID, AName, _), certified(EID, AID), employees(EID, _, Salary), Salary > 80000.

hasPilotUnder80000(AID, AName):- aircraft(AID, AName, _), certified(EID, AID), employees(EID, _, Salary), Salary < 80000.
q1(AName):- aircraft(AID, AName, _), \+ hasPilotUnder80000(AID, AName).

% Find the names of pilots whose salary is less than the price of the route from Los Angeles to Honolulu.
q2(EName):- employees(_, EName, Salary), flights(_, la, hnl, _, _, _, Cost), Salary < Cost. 

% Find the names of pilots certified for the Boeing747 aircraft.
q3(EName):- aircraft(AID, boeing747, _), certified(EID, AID), employees(EID, EName, _).

% Find the AIDs of all aircraft that can be used on routes from Los Angeles to Chicago
q4(AID):- flights(_, lax, ord, Dist, _, _, _), aircraft(AID, _, CruisingDist), CruisingDist > Dist.

% Print the names of employees who are certified only on aircrafts with cruising range longer than 1000 miles, but on at least two such aircrafts.
q5wrong(EName):- employees(EID, EName, _), certified(EID, AID1), aircraft(AID1, _, CruisingDist1), certified(EID, AID2), aircraft(AID2, _, CruisingDist2), CruisingDist1 > 1000, CruisingDist2 > 1000, \+ AID1 = AID2.

hasCruisingUnder1000(EID, EName):- employees(EID, EName, _), certified(EID, AID), aircraft(AID, _, CruisingDist), CruisingDist < 1000.
q5(EName):- employees(EID, EName, _), certified(EID, AID1), aircraft(AID1, _, CruisingDist1), certified(EID, AID2), aircraft(AID2, _, CruisingDist2), CruisingDist1 > 1000, CruisingDist2 > 1000, \+ AID1 = AID2, \+ hasCruisingUnder1000(EID, EName).
