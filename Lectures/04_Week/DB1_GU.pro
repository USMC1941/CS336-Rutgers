student(s1, anne, ece, sr, 21).
student(s2, bob, compsci, sr, 23).
student(s3, cara, compsci, jr, 21).
student(s4, dylan, bio, jr, 20).
student(s5, eugene, bio, sp, 19).
student(s6, frank, ece, sp, 20).
student(s7, grady, ece, fr, 19).
student(s8, hannah, compsci, fr, 18).

class(database, 1200, be250, f1).
class(prinprog, 1500, hill114, f1).
class(ai, 1020, serc111, f2).
class(circuits, 0840, serc111, f3).
class(orgo, 0840, arc103, f4).

enrolled(s1, circuits).
enrolled(s2, database).
enrolled(s3, ai).
enrolled(s3, prinprog).
enrolled(s4, orgo).
enrolled(s5, orgo).
enrolled(s5, database).
enrolled(s6, circuits).
enrolled(s6, prinprog).
enrolled(s8, ai).

faculty(f1, borgida, d1).
faculty(f2, bekris, d1).
faculty(f3, chen, d2).
faculty(f4, durham, d3).

% Find the names of all juniors who are enrolled in a class taught by Borgida
 % student (of all juniors) -> names  -> enrolled -> class -> Borgida
 % student(SID, SName, _, jr, _), enrolled(SID, CName), class(CName, _, _, FID), faculty(FID, borgida, _).
q1(SName):- student(SID, SName, _, jr, _), class(CName, _, _, FID), enrolled(SID, CName), faculty(FID, borgida, _).

% Find the age of the student who is either a Bio major or enrolled in a course taught by Borgida
 % q2(Age):- student(_, _, bio, _, Age); student(SID, _, _, _, Age), enrolled(SID, CName), class(CName, _, _, FID), faculty(FID, borgida, _).
q2(Age):- student(_, _, bio, _, Age).
q2(Age):- student(SID, _, _, _, Age), enrolled(SID, CName), class(CName, _, _, FID), faculty(FID, borgida, _).

% Find the names of all students who are enrolled in two classes that meet at the same time
q3(SName):- student(SID, SName, _, _, _), enrolled(SID, CName1), enrolled(SID, CName2), class(CName1, Time, _, _), class(CName2, Time, _, _), \+ CName1 = CName2.
%
q3(SName):- class(CName1, Time, _, _), enrolled(SID, CName1), student(SID, SName, _, _, _), enrolled(SID, CName2), class(CName2, Time, _, _), \+ CName1 = CName2.


% Find the names of students not enrolled in any class
q4(SName):- student(SID, SName, _, _, _), \+ enrolled(SID, _).






