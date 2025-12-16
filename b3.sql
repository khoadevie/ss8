CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    job_level INT,
    salary NUMERIC
);

INSERT INTO employees (emp_name, job_level, salary) VALUES
('Nguyen Van A', 1, 10000000),
('Tran Thi B', 2, 12000000),
('Le Van C', 3, 15000000);

CREATE OR REPLACE PROCEDURE adjust_salary(
    p_emp_id INT,
    OUT p_new_salary NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_salary NUMERIC;
    v_job_level INT;
BEGIN
    SELECT salary, job_level
    INTO v_salary, v_job_level
    FROM employees
    WHERE emp_id = p_emp_id;

    IF v_salary IS NULL THEN
        RAISE EXCEPTION 'Employee not found';
    END IF;

    IF v_job_level = 1 THEN
        v_salary := v_salary * 1.05;
    ELSIF v_job_level = 2 THEN
        v_salary := v_salary * 1.10;
    ELSIF v_job_level = 3 THEN
        v_salary := v_salary * 1.15;
    END IF;

    UPDATE employees
    SET salary = v_salary
    WHERE emp_id = p_emp_id;

    p_new_salary := v_salary;
END;
$$;

CALL adjust_salary(3, NULL);
