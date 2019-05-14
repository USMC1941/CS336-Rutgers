suppliers(s1, supplyshop, twelveMainStreet).
suppliers(s2, warehouse, fiveMeadowAve).
suppliers(s3, dollarstore, sevenAllenDrive).

parts(p1, pen, red).
parts(p2, pen, red). 
parts(p3, paper, green).
parts(p4, clip, red).

catalog(s1, p1, 2). 
catalog(s1, p2, 3).
catalog(s2, p1, 3). 
catalog(s2, p4, 4).
catalog(s3, p3, 2).
catalog(s3, p4, 3).

% Find the part names of parts for which there is some supplier
q1(PName):- parts(PID, PName, _), catalog(_, PID, _).

% Find the SIDs of suppliers who supply only red parts
% Returns SID if supplier sells at least one red part
wrong(SID):- suppliers(SID, _, _), catalog(SID, PID, _), parts(PID, _, red).

% Find suppliers who sell parts other than red
supplyOtherThanRed(SID):- suppliers(SID, _, _), catalog(SID, PID, _), \+ parts(PID, _, red).
q2(SID):- suppliers(SID, _, _), parts(PID, _, red), catalog(SID, PID, _), \+ supplyOtherThanRed(SID).

% Find the SIDs of suppliers who supply a red part or a green part
q3(SID):- suppliers(SID, _, _), parts(PID, _, red), catalog(SID, PID, _).
q3(SID):- suppliers(SID, _, _), parts(PID, _, green), catalog(SID, PID, _).

% Find the name of the suppliers that supply at least 2 parts that cost more than $2 and have red color
q4(SName):- suppliers(SID, SName, _), catalog(SID, PID1, Cost1), parts(PID1, _, red), catalog(SID, PID2, Cost2), parts(PID2, _, red), Cost1 > 2, Cost2 > 2, \+(PID1 = PID2).

% Find the SIDs of suppliers who supply a red part and a green part.
q5(SID):- suppliers(SID, _, _), catalog(SID, PID1, _), parts(PID1, _, red), catalog(SID, PID2, _), parts(PID2, _, green).