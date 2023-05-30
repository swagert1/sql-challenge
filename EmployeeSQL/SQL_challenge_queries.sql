-- SQL challenge queries

-- 1. List the employee number, last name, first name, sex, and salary of each employee
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary 
from employees as e
join salaries as s on e.emp_no = s.emp_no; 

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986
select last_name, first_name, hire_date 
from employees where 
extract(year from hire_date) = '1986';

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name
select dm.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name 
from employees as e
join dept_manager dm on e.emp_no = dm.emp_no 
join departments as d on d.dept_no = dm.dept_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name
select d.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name 
from employees as e 
join dept_emp as de on e.emp_no = de.emp_no
join departments as d on d.dept_no = de.dept_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
select first_name, last_name, sex 
from employees 
where first_name = 'Hercules' and last_name like('B%');

-- 6. List each employee in the Sales department, including their employee number, last name, and first name

-- Using joins
select e.emp_no, e.last_name, e.first_name, d.dept_name 
from employees as e
join dept_emp as de on e.emp_no = de.emp_no
join departments as d on de.dept_no = d.dept_no
where d.dept_name = 'Sales'
order by last_name;

-- Using subqueries
select emp_no, last_name, first_name
from employees
where emp_no in (
	select emp_no
	from dept_emp
	where dept_no in (
			select dept_no
			from departments
			where dept_name = 'Sales'
			)
	)
order by last_name;

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name

-- Using joins
select e.emp_no, e.last_name, e.first_name, d.dept_name 
from employees as e
join dept_emp as de on e.emp_no = de.emp_no
join departments as d on de.dept_no = d.dept_no
where d.dept_name = 'Sales' or d.dept_name = 'Development'
order by e.last_name;

-- Using subqueries
select emp_no, last_name, first_name
from employees
where emp_no in (
	select emp_no
	from dept_emp
	where dept_no in (
			select dept_no
			from departments
			where dept_name = 'Sales' or dept_name = 'Development'
			)
	)
order by last_name;

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
select count(last_name) as frequency, last_name 
from employees 
group by last_name 
order by count(last_name) desc;
