# Triggers Overview

## Trigger Overview

Another component of a database management system that supports maintenance of integrity is a trigger facility. This is not a SQL standard, but many installations support the concept.

The general form of components are: `ON <event> IF <condition> THEN <action>`
* `event` - request to execute database operation
* `condition` - predicate evaluated on database state
* `action` – execution of procedure that might involve database updates

Example (in pseudo language):
```
ON updating maximum course enrollment
IF number registered > new max enrollment limit
THEN deregister students using LIFO policy
```

## Trigger Details

**Activation** - The occurrence of the event

**Consideration** - After activation, the point when a condition is evaluated
* *immediate* (associated with the SQL statement) or
* *deferred* (when the transaction requests are to commit)
* The *condition* might refer to both the state before and the state after the event occurs

**Execution** - The point at which the action occurs
* With deferred consideration, execution is also deferred
* With immediate consideration, execution can occur immediately after consideration or it can be deferred
* If execution is immediate, execution can occur before, after, or instead of the triggering event.
* Before triggers adapt naturally to maintaining integrity constraints: violation results in rejection of event.

**Granularity** - The extent of the database to which the trigger applies
* Row-level granularity: change of a single row is an event (a single `UPDATE` statement might result in multiple events)
* Statement-level granularity: events are statements (a single `UPDATE` statement that changes multiple rows is a single event).

**Multiple Triggers**
* How should multiple triggers activated by a single event be handled?
  * Evaluate one condition at a time, and if true immediately execute action, or
  * Evaluate all conditions, then execute actions
* The execution of an action can affect the truth of a subsequently evaluated condition so the choice is significant.

## Triggers in SQL:1999

**Consideration**: Immediate
* Condition can refer to both the state of the affected row or table before and after the event occurs

**Execution**: Immediate - can be before or after the execution of triggering event .
* Action of before trigger cannot modify the database

**Granularity**: Both row-level and statement-level granularity

```sql
CREATE TRIGGER trigger-name
   {BEFORE | AFTER} {INSERT | DELETE | UPDATE [OF column(s)]}
   ON table-name
      [REFERENCING [OLD AS varRefToOldTuple]
                   [NEW AS varRefToNewTuple]
                   [OLD TABLE AS nameToRefOldTable]
                   [NEW TABLE AS nameToRefNewTable]]
      [FOR EACH {ROW | STATEMENT } ]
      [WHEN (condition) ]
        statement list
```

### Before Trigger Example (row granularity)

```sql
CREATE TRIGGER Max EnrollCheck
   BEFORE INSERT ON Transcript
      REFERENCING NEW AS N --row to be added
FOR EACH ROW
WHEN
((SELECT COUNT (T.StudId) FROM Transcript T
   WHERE T.CrsCode = N.CrsCode
     AND T.Semester = N.Semester) >=
           (SELECT C.MaxEnroll FROM Course C
              WHERE C.CrsCode = N.CrsCode ))
            ABORT TRANSACTION
```

### After Trigger Example (row granularity)

```sql
CREATE TRIGGER LimitSalaryRaise
  AFTER UPDATE OF Salary ON Employee
  REFERENCING OLD AS O
            NEW AS N
  FOR EACH ROW
  WHEN (N.salary - O.Salary > 0.05 * O.Salary)
     UPDATE Employee -- action
     SET Salary = 1.05 * O.Salary
     WHERE Id = O.Id
```
Note: The action itself is a triggering event (but in this case a chain reaction is not possible)

### After Trigger Example (statement granularity)

```sql
CREATE TRIGGER RecordNewAverage
  AFTER UPDATE OF Salary ON Employee
  FOR EACH STATEMENT
    INSERT INTO Log
    VALUES (CURRENT_DATE,
          SELECT AVG (Salary)
          FROM Employee)
```

## Triggers in PostgreSQL

[Documentation Link](https://www.postgresql.org/docs/current/plpgsql-trigger.html)

```sql
CREATE TRIGGER name
       { BEFORE | AFTER } { event [ OR ... ] }
       ON table [ FOR [ EACH ] { ROW | STATEMENT } ]
       EXECUTE PROCEDURE funcname ( arguments )
```
* *event* is `UPDATE`, `DELETE`, or `INSERT` (combine with `OR`)
* *arguments* are comma separated and are literal string constants.

### Compatibility

The `CREATE TRIGGER` statement in PostgreSQL implements a subset of the SQL:1999 standard. (There are no provisions for triggers in SQL-92.) The following functionality is missing:
* SQL:1999 allows triggers to fire on updates to specific columns (e.g., `AFTER UPDATE OF col1, col2`).
* SQL:1999 allows you to define aliases for the "old" and "new" rows or tables for use in the definition of the triggered action (e.g., `CREATE TRIGGER ... ON tablename REFERENCING OLD ROW AS somename NEW ROW AS othername ...`). Since PostgreSQL allows trigger procedures to be written in any number of user-defined languages, access to the data is handled in a language-specific way.
* PostgreSQL only allows the execution of a user-defined function for the triggered action. SQL:1999 allows the execution of a number of other SQL commands, such as `CREATE TABLE` as triggered action. This limitation is not hard to work around by creating a user-defined function that executes the desired commands.

SQL:1999 specifies that multiple triggers should be fired in time-of-creation order. PostgreSQL uses name order, which was judged more convenient to work with.

## Before trigger example:
```sql
CREATE TABLE emp (
    empname text,
    salary integer,
    last_date timestamp,
    last_user text
);

CREATE FUNCTION emp_stamp() RETURNS trigger AS $emp_stamp$
    BEGIN
        -- Check that empname and salary are given
        IF NEW.empname IS NULL THEN
            RAISE EXCEPTION 'empname cannot be null';
        END IF;
        IF NEW.salary IS NULL THEN
            RAISE EXCEPTION '% cannot have null salary', NEW.empname;
        END IF;

        -- Who works for us when she must pay for it?
        IF NEW.salary < 0 THEN
            RAISE EXCEPTION '% cannot have a negative salary', NEW.empname;
        END IF;

        -- Remember who changed the payroll when
        NEW.last_date := current_timestamp;
        NEW.last_user := current_user;
        RETURN NEW;
    END;
$emp_stamp$ LANGUAGE plpgsql;

CREATE TRIGGER emp_stamp BEFORE INSERT OR UPDATE ON emp
    FOR EACH ROW EXECUTE PROCEDURE emp_stamp();
```

## Trigger variables

There are a number of set variables available to get the context of the trigger event:

`NEW`
* Data type `RECORD`; variable holding the new database row for `INSERT`/`UPDATE` operations in row-level triggers. This variable is NULL in statement-level triggers.

`OLD`
* Data type `RECORD`; variable holding the old database row for `UPDATE`/`DELETE` operations in row-level triggers. This variable is `NULL` in statement-level triggers.

`TG_NAME`
* Data type name; variable that contains the name of the trigger actually fired.

`TG_WHEN`
* Data type text; a string of either `BEFORE` or `AFTER` depending on the trigger's definition.

`TG_LEVEL`
* Data type text; a string of either `ROW` or `STATEMENT` depending on the trigger's definition.

`TG_OP`
* Data type text; a string of `INSERT`, `UPDATE`, or `DELETE` telling for which operation the trigger was fired.

`TG_RELID`
* Data type oid; the object ID of the table that caused the trigger invocation.

`TG_RELNAME`
* Data type name; the name of the table that caused the trigger invocation. This is now deprecated, and could disappear in a future release. Use `TG_TABLE_NAME` instead.

`TG_TABLE_NAME`
* Data type name; the name of the table that caused the trigger invocation.

`TG_TABLE_SCHEMA`
* Data type name; the name of the schema of the table that caused the trigger invocation.

`TG_NARGS`
* Data type integer; the number of arguments given to the trigger procedure in the `CREATE TRIGGER` statement.

`TG_ARGV[]`
* Data type array of text; the arguments from the `CREATE TRIGGER` statement. The index counts from 0. Invalid indices (less than 0 or greater than or equal to `tg_nargs`) result in a null value.

A trigger function must return either `NULL` or a record/row value having exactly the structure of the table the trigger was fired for.

## plpgsql

Programming Language for PostgreSQL (PL/pgSQL)

This is a full language to produce procedures and transaction control.

See the [Server Programming](https://www.postgresql.org/docs/current/server-programming.html) section of the Postgres on-line manual for details.

The SQL Procedural Language documentation is found [here](https://www.postgresql.org/docs/current/plpgsql.html).


```sh
-bash-3.00$ cat funcs.sql
```

```sql
DROP TRIGGER UpdateTotalTrigger ON states;

DROP FUNCTION resetPopTotal();

CREATE FUNCTION resetPopTotal()
RETURNS trigger AS $$
BEGIN
    UPDATE state_stats
    set value = (SELECT Sum(pop) from states)
    WHERE attribute = 'total';
    RETURN null;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER UpdateTotalTrigger
AFTER UPDATE OR DELETE OR INSERT
ON states FOR STATEMENT
EXECUTE PROCEDURE resetPopTotal();
```

Use the above basic example to construct a function/procedure to place pgplsql code and then the trigger reference.

Basic statements include:
```sql
SELECT expression;

variable := expression; -- Variables should be declared

DECLARE
var type;
var type;...
BEGIN

BEGIN
statements;
END;

BEGIN
statements;
EXCEPTION
WHEN condition THEN statement
WHEN condition THEN statement..
END
```

### IF statements

`IF` statements let you execute commands based on certain conditions. PL/pgSQL has five forms of `IF`:
1.  `IF ... THEN`
2.  `IF ... THEN ... ELSE`
3.  `IF ... THEN ... ELSE IF`
4.  `IF ... THEN ... ELSIF ... THEN ... ELSE`
5.  `IF ... THEN ... ELSEIF ... THEN ... ELSE`

All end with `END IF;`

### Looping
```sql
LOOP
    -- some computations
    IF count > 0 THEN
        EXIT;  -- exit loop
    END IF;
END LOOP;

LOOP
    -- some computations
    EXIT WHEN count > 0;  -- same result as previous example
END LOOP;

BEGIN
    -- some computations
    IF stocks > 100000 THEN
        EXIT;  -- causes exit from the BEGIN block
    END IF;
END;

[ <<label>>  ]
WHILE boolean-expression LOOP
    statements
END LOOP [ label ];

WHILE amount_owed > 0 AND gift_certificate_balance > 0 LOOP
    -- some computations here
END LOOP;

WHILE NOT done LOOP
    -- some computations here
END LOOP;

[ <<label>>  ]
FOR name IN [ REVERSE ] expression .. expression [ BY expression ] LOOP
    statements
END LOOP [ label ];

FOR i IN 1..10 LOOP
    -- i will take on the values 1,2,3,4,5,6,7,8,9,10 within the loop
END LOOP;

FOR i IN REVERSE 10..1 LOOP
    -- i will take on the values 10,9,8,7,6,5,4,3,2,1 within the loop
END LOOP;

FOR i IN REVERSE 10..1 BY 2 LOOP
    -- i will take on the values 10,8,6,4,2 within the loop
END LOOP;
```

### Exceptions
This example uses exception handling to perform either UPDATE or INSERT, as appropriate:
```sql
CREATE TABLE db (a INT PRIMARY KEY, b TEXT);

CREATE FUNCTION merge_db(key INT, data TEXT) RETURNS VOID AS
$$
BEGIN
    LOOP
        -- first try to update the key
        UPDATE db SET b = data WHERE a = key;
        IF found THEN
            RETURN;
        END IF;
        -- not there, so try to insert the key
        -- if someone else inserts the same key concurrently,
        -- we could get a unique-key failure
        BEGIN
            INSERT INTO db(a,b) VALUES (key, data);
            RETURN;
        EXCEPTION WHEN unique_violation THEN
            -- do nothing, and loop to try the UPDATE again
        END;
    END LOOP;
END;
$$
LANGUAGE plpgsql;

SELECT merge_db(1, 'david');
SELECT merge_db(1, 'dennis');
```