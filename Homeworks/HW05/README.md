# HW05: SQL and Relational Algebra Queries

1. Give the SQL definitions of the tables:

   ```
   CrossCountrySkier(Name, Country, Age)
   Competes(SkierName,ContestName, Placement)
   Contest (Name, Place, Country, Length)
   ```

   Showing particularly the foreign key constraints of the `Competes` table.

---

2. Given the following schema:

   ```
   Airport (City, Country, NumberOfRunways)
   Flight (FlightID, Day, DepartCity, DepartTime, ArrCity, ArrTime, PlaneType)
   Plane (PlaneType, NumberOfPassengers)
   ```

   The question we want to find out:

   > The Belgian airport that have only domestic flights.

   -  Show this query in SQL using `EXCEPT` or `NOT IN` (pick only one):
   -  Show this query in Relational Algebra

---

3. Give a sequence of update commands that alter the attribute `Salary` in the `Employee` table, increasing by 10% the salaries below 30 thousand and decreasing by 5% those above 30 thousand.

---

4. Give the SQL definitions of the tables:

   ```
   Author (FirstName, Surname, DateofBirth, Nationality)
   Book (BookTitle, AuthorFirstName, authorSurname, Language)
   ```

   For the foreign key constraint, specify a cascade policy on deletion.
