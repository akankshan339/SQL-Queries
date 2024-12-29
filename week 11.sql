create table employee4(empid int Primary Key, empname varchar2(10), sal int);


insert all
into employee4 values(101, 'Akanksha', 50000)
into employee4 values(102, 'Kiran', 80000)
into employee4 values(103, 'Gunjan', 40000)
into employee4 values(104, 'Astha', 45000)
into employee4 values(105, 'Swati', 60000)
select* from dual;



CREATE OR REPLACE TRIGGER salary_difference_trigger
AFTER INSERT OR UPDATE OR DELETE ON employee4
FOR EACH ROW
BEGIN
    -- Check if the operation is UPDATE
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('Salary Inserted: ' || :NEW.sal);
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('Salary Deleted: ' || :OLD.sal);
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('Salary Difference: Old Salary = ' || :OLD.sal || ', New Salary = ' || :NEW.sal);
    END IF;
END;
/



insert into employee4(empid, empname, sal) values(106, 'Appu', 65000);


update employee4 SET empname = 'Prtibha' where empid = 104;

delete from employee4 where empid = 105;

CREATE OR REPLACE TRIGGER empname_uppercase_trigger
BEFORE INSERT OR UPDATE ON employee4
FOR EACH ROW
BEGIN
    --convert the employee name to upper case
    :NEW.empname := UPPER(:NEW.empname);
END;
/


DROP TRIGGER salary_difference_trigger;

