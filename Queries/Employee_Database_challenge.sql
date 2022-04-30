select 
    e.emp_no, 
    e.first_name, 
    e.last_name, 
    t.title, 
    t.from_date, 
    t.to_date
into retirement_titles
from employees as e
join titles as t on t.emp_no=e.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
order by e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

--retrieve number of employees by most recent job title who are about to retire
select count(emp_no), title
into retiring_titles
from unique_titles
group by title
order by count(emp_no) desc;

--create mentorship eligibility table 
--holds employees eligible to participate in mentorship program
select distinct on (emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
into mentorship_eligibility
from employees as e
join titles as t on t.emp_no=e.emp_no
join dept_emp as de on de.emp_no = e.emp_no
WHERE t.to_date = '9999-01-01' and
e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
order by e.emp_no;