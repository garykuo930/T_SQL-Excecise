--------------------------------------------------------------------------------------
--Exercise 1: Using a Subquery to Correlate Data 找出罰款總額（Sum(Fine_Assessed)）大於5元的會員

--Note   You also can write this query with a join and a GROUP BY or HAVING clause instead of a correlated subquery.

--?	Write a query that returns the member_no, FirstName and lastname columns of the member table.
--?	Write a query that calculates the total fines for each member as recorded in the loanhist table.
--?	Use a comparison operator in the WHERE clause of the outer query to select those members who have fines that total more than $5.00.
--------------------------------------------------------------------------------------
--Method 1 : using group by and having
--------------------------------------------------------------------------------------
use Library
select mem.member_no, FirstName, lastname,sum(lnht.fine_assessed) as 'Total fines'
from member as mem
join loanhist as lnht
on  mem.member_no = lnht.member_no
group by mem.member_no, FirstName, lastname
having sum(lnht.fine_assessed) > 5
order by [Total fines]
Go
--------------------------------------------------------------------------------------
--Method 2 : using subquery
--------------------------------------------------------------------------------------
use Library
select
	mem.member_no,
	FirstName, lastname,
	(select sum(loanhist.fine_assessed) from loanhist
	where mem.member_no = loanhist.member_no) as 'Total fines'
from member as mem
where 5 < (
select sum(loanhist.fine_assessed) from loanhist
where mem.member_no = loanhist.member_no)
order by [Total fines]
Go
--------------------------------------------------------------------------------------
--Exercise 2: Using a Subquery as a Derived Table找出有三個以上未成年子女的會員
--To execute a query that uses a derived table 
-- 1.	In this procedure, you will write and execute a query that
--uses a derived table and returns the juvenile.adult_member_no column, the expr_date column data
--from the adult table and the number of juveniles for each adult member who has more than three juvenile members.

--2.	In this procedure, you will rewrite and execute the original derived table query
--as a join of two separate queries to show that you can obtain the same results as using a derived table. 
--------------------------------------------------------------------------------------
use Library

select distinct adult.[member_no],[expr_date]
from [dbo].[adult]
join [dbo].[juvenile]
on adult.[member_no] = juvenile.[adult_member_no]
where adult.[member_no] in (
	select [adult_member_no]
	from [dbo].[juvenile]
	group by [adult_member_no]
	having count(*) > 3)
--------------------------------------------------------------------------------------
--	Exercise 3: Using a Subquery as an Expression 找出支付罰款金額最高的會員
--1.	In this procedure, you will write and execute a query that returns
-- member.firstname, member.lastname, loanhist.isbn, and loanhist.fine_paid
-- for members who have paid the highest recorded fines for all books.

--Include the DISTINCT keyword in your query to eliminate entries for members
-- who have paid this fine on several occasions.

--3.	Write an outer query that returns the title_no, title, isbn, and Total Reserved columns in which
--the Total Reserved column is the number of records for each group of title_no, title, and isbn. To do this:
--?	Restrict the rows that form the groups in the outer query by specifying books that have less than five copies.
--?	Use the IN keyword as part of the WHERE clause against the list of isbn reserved
--------------------------------------------------------------------------------------
use Library
select distinct member.firstname, member.lastname, loanhist.isbn, loanhist.fine_paid
from member
join loanhist
on member.member_no = loanhist.member_no
where loanhist.fine_paid = (
select Max(fine_paid)
from loanhist)
--------------------------------------------------------------------------------------
--2.	
--In this procedure, you will write and execute a query on the title, loan, and reservation tables that
-- returns four columns: title_no, title, isbn, and Total Reserved.
-- The Total Reserved column is the per-isbn (book) count of books on reserve with
-- more than 50 reservations and less than five copies of the book.
--Group the results by title_no, title, and isbn .

--To use a multiple-value subquery 
--------------------------------------------------------------------------------------
select distinct title.title_no, title, loan.isbn, loan.copy_no, count(*) as 'Total Reserved'
from loan
join title
on title.title_no = loan.title_no
join reservation
on reservation.isbn = loan.isbn
--where reservation.isbn in (
--	select isbn
--	from reservation
--	group by isbn
--	having count(member_no) > 50)
--	and
--	copy_no < 5
group by title.title_no, title, loan.isbn, loan.copy_no n
having count(*) > 50 and copy_no < 5
--------------------------------------------------------------------------------------
--3.	Write an outer query that returns the title_no, title, isbn, and Total Reserved columns in which
--		the Total Reserved column is the number of records for each group of title_no, title, and isbn. To do this:
--?	Restrict the rows that form the groups in the outer query by specifying books that have less than five copies.
--?	Use the IN keyword as part of the WHERE clause against the list of isbn reserved
--------------------------------------------------------------------------------------



