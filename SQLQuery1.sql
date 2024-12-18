select * from [bank-loan_data]
select count(id) as Total_Loan_Application  from [bank-loan_data]
select count(id) as MTD_Total_Loan_Application  from [bank-loan_data]
where month(issue_date)=12 and year(issue_date)=2021
select sum(loan_amount) as MTD_Total_Funded_Amount from [bank-loan_data]
where month(issue_date)=12 and year(issue_date)=2021
select sum(loan_amount) as PMTD_Total_Funded_Amount from [bank-loan_data]
where month(issue_date)=11 and year(issue_date)=2021
select sum(total_payment) as MTD_Total_Amount_Received from [bank-loan_data]
where month(issue_date)=12 and year(issue_date)=2021
select sum(total_payment) as PMTD_Total_Amount_Received from [bank-loan_data]
where month(issue_date)=11 and year(issue_date)=2021
select round(avg(int_rate),4)*100 as MTD_AVG_Interest_Rate from [bank-loan_data]
where month(issue_date)=12 and year(issue_date)=2021
select round(avg(int_rate),4)*100 as PMTD_AVG_Interest_Rate from [bank-loan_data]
where month(issue_date)=11 and year(issue_date)=2021
select round(avg(dti),4)*100 as MTD_AVG_DTI from [bank-loan_data]
where month(issue_date)=12 and year(issue_date)=2021
select round(avg(dti),4)*100 as PMTD_AVG_DTI from [bank-loan_data]
where month(issue_date)=11 and year(issue_date)=2021
--Good Loan
select
	count(case when loan_status in('Fully Paid', 'Current' ) then id end)*100.0/count(id) as Good_Loan_Percentage
from
	[bank-loan_data];
select count(id) as Good_Loan_Application from [bank-loan_data]
where loan_status='Fully Paid'or loan_status='Current'
select sum(loan_amount) as Good_Loan_Funded_Amount from[bank-loan_data]
where loan_status in('Current','Fully Paid')
select sum(total_payment) as Good_Loan_Recived_Amount from[bank-loan_data]
where loan_status in('Current','Fully Paid')

--Bad Loan
select
	count(case when loan_status='Charged Off'  then id end)*100.0/count(id) as Bad_Loan_Percentage
from
	[bank-loan_data];
select count(id) as Bad_Loan_Application from [bank-loan_data]
where loan_status='Charged Off'
select sum(loan_amount) as Bad_Loan_Funded_Amount from[bank-loan_data]
where loan_status='Charged Off'
select sum(total_payment) as Bad_Loan_Recived_Amount from[bank-loan_data]
where loan_status='charged Off'
--Loan Status Grid
select
    loan_status,
    count(id) as LoanCount,
    sum(total_payment) as Total_Amount_Received,
    sum(loan_amount) as Total_Funded_Amount,
    avg(int_rate) * 100 as Interest_Rate,
    avg(dti) * 100 as DTI
from 
    [bank-loan_data]
group by 
    loan_status;
--Current Month(12) Loan Status Grid
select
    loan_status,
    sum(total_payment) as MTD_Total_Amount_Received,
    sum(loan_amount) as MTD_Total_Funded_Amount
from 
    [bank-loan_data]
where 
    month(issue_date) = 12
group by 
    loan_status;
--Previous Month(11) Loan Status Grid
select
    loan_status,
    sum(total_payment) as PMTD_Total_Amount_Received,
    sum(loan_amount) as PMTD_Total_Funded_Amount
from 
    [bank-loan_data]
where 
    month(issue_date) = 11
group by 
    loan_status;
--Monthly Trend 
select 
    month(issue_date) as Total_Month_Number, 
    datename(month, issue_date) as Total_Month_Name, 
    count(id) as Total_Loan_Applications, 
    sum(loan_amount) as Total_Funded_Amount, 
    sum(total_payment) as Total_Amount_Received 
from [bank-loan_data] 
group by month(issue_date), datename(month, issue_date) 
order by month(issue_date);

--Regional Analysis
select 
    address_state, 
    count(id) as Total_Loan, 
    sum(loan_amount) as Total_Funded_Amount, 
    sum(total_payment) as Total_Amount_Received 
from [bank-loan_data] 
group by address_state 
order by count(id) desc;
--Loan Term Analysis
select 
    term, 
    count(id) as Total_Loan, 
    sum(loan_amount) as Total_Funded_Amount, 
    sum(total_payment) as Total_Amount_Received 
from [bank-loan_data] 
group by term
order by term;
--Employee Term
select 
    emp_length, 
    count(id) as Total_Loan, 
    sum(loan_amount) as Total_Funded_Amount, 
    sum(total_payment) as Total_Amount_Received 
from [bank-loan_data] 
group by emp_length
order by count(id) desc;
--Purpose
select 
    purpose, 
    count(id) as Total_Loan, 
    sum(loan_amount) as Total_Funded_Amount, 
    sum(total_payment) as Total_Amount_Received 
from [bank-loan_data] 
group by purpose
order by count(id) desc;
--Home Ownership
select 
    home_ownership, 
    count(id) as Total_Loan, 
    sum(loan_amount) as Total_Funded_Amount, 
    sum(total_payment) as Total_Amount_Received 
from [bank-loan_data]
where grade='A' and address_state='CA'
group by home_ownership
order by count(id) desc;

