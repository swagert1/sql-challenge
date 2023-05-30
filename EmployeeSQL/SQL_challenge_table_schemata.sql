-- SQL challenge table schemata

drop table if exists titles; -- use this line to drop table(s) if needed

create table titles(
	title_id varchar(50) primary key not null,
	title varchar(50) not null
);

select * from titles; -- select statments are used to confirm data import

create table employees(
	emp_no serial primary key not null,
	emp_title_id varchar(50) not null,
	foreign key (emp_title_id) references titles(title_id),
	birth_date date not null,
	first_name varchar(50) not null,
	last_name varchar(100) not null,
	sex varchar(1) not null,
	hire_date date not null
);

select * from employees;

create table departments(
	dept_no varchar(10) primary key not null,
	dept_name varchar(50) not null
);

select * from departments;

create table dept_emp(
	emp_no serial not null,
	foreign key (emp_no) references employees(emp_no), 
	dept_no varchar(50) not null,
	foreign key (dept_no) references departments(dept_no),
	primary key (emp_no, dept_no) -- need to reference two columns as a unique row identifier 
								  -- since there are duplicate entries in the emp_no column
);

select * from dept_emp;

select count(emp_no) from dept_emp;
select distinct emp_no, dept_no from dept_emp;

--checking for duplicate entries (some employees may work in more than one department)
select emp_no, count(emp_no) from dept_emp group by emp_no having count(emp_no) > 1;
select * from dept_emp where emp_no = '46227';

create table dept_manager(
	dept_no varchar(50) not null,
	foreign key (dept_no) references departments(dept_no),
	emp_no serial not null,
	foreign key (emp_no) references employees(emp_no), 
	primary key (emp_no, dept_no) -- need to reference two columns as a unique row identifier
);

select * from dept_manager;

create table salaries(
	emp_no serial not null primary key,
	foreign key (emp_no) references employees(emp_no), 
	salary int not null
);

select * from salaries;
