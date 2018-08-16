--------------------------------------------------------------------------------------
--Joining Tables
--------------------------------------------------------------------------------------
--Exercise 1
--Write a query on the member and adult tables that returns
--the firstname, middleinitial, lastname, street, city, state, and zip values.
--Concatenate the firstname, middleinitial and lastname columns into one string and alias the column as name.
--Answer_Mailing.sql is a completed script for this procedure.
--------------------------------------------------------------------------------------
use Library
select (firstname+' '+middleinitial+' '+lastname) as name, street, city, state, zip
from [dbo].[member] mem
Inner Join [dbo].[adult] adt
On adt.member_no = mem.member_no
Go
--------------------------------------------------------------------------------------
--Exercise 2
--Join member and reservation tables by using an outer join:
--Write and execute a query to retrieve the member's full name
--and member_no from the member table and the isbn
--and log_date values from the reservation table for member numbers 250, 341, and 1675.
--Order the results by member_no. 
--You should show information for these members, even if they have no books on reserve.
--------------------------------------------------------------------------------------
use Library
select (firstname+' '+middleinitial+' '+lastname) as name, mem.[member_no], [isbn], [log_date]
from [dbo].[member] mem left outer join [dbo].[reservation] rsv
on mem.[member_no] = rsv.[member_no]
where mem.[member_no] in (250, 341, 1675)
Go
--------------------------------------------------------------------------------------
--Join title, item, and copy 三個 table 並依isbn欄位排序： 
--------------------------------------------------------------------------------------
--Exercise 3
--Write and execute a query on the title, item, and copy tables that
--returns the isbn, copy_no, on_loan, title, translation, and cover,
--and values for rows in the copy table with an ISBN of
--1 (one), 500(five hundred), or 1000 (one thousand).
--Order the results by the isbn column.
--------------------------------------------------------------------------------------
use Library
select item.isbn, copy_no, on_loan, title, translation, cover
from [dbo].[copy]
join [dbo].[title] 
on copy.title_no = title.title_no
join [dbo].[item]
on copy.isbn = item.isbn
where item.isbn in (1,500,1000)
order by isbn,copy_no
--------------------------------------------------------------------------------------
--使用Self Join
--------------------------------------------------------------------------------------
use joindb
select a.buyer_id as Buyer1, a.prod_id, b.buyer_id as Buyer2
from Sales a
join Sales b
on a.prod_id = b.prod_id
--where a.buyer_id > b.buyer_id
order by a.buyer_id
Go
--------------------------------------------------------------------------------------
use Library
select a.emp_id,a.name as 'Emp Name',a.mgr_id,b.emp_id,b.name as 'Mgr Name'
from emp a
join emp b
on b.emp_id = a.mgr_id
where a.name = 'Peter'
Go
--------------------------------------------------------------------------------------
--使用Union合併查詢
--1. 資料型態須相似
--2. 欄位數量須相同
--3. 欄位順序須一致
--------------------------------------------------------------------------------------
use Northwind
select FirstName+' '+LastName as 'Name', City, PostalCode from Employees
union
select ContactName, City, PostalCode from Customers
