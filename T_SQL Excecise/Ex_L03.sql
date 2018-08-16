use Library

--------------------------------------------------------------------------------------
--Retrieving Data
--------------------------------------------------------------------------------------
--Exercise 1
--Write and execute a SELECT statement that
--retrieves the title and title_no columns from the title table. 
--Answer_Columns.sql is a completed script for this step .
--------------------------------------------------------------------------------------
select [title_no],[title]
from [dbo].[title]
where title = 'Poems'
Go

--------------------------------------------------------------------------------------
--Exercise 2
--Write and execute a SELECT statement that retrieves the title of title number 10 from the title table. 
--You can execute the sp_help system stored procedure for the title table to find the correct column names.
--Answer_Comparison.sql is a completed script for this procedure.
--------------------------------------------------------------------------------------

sp_help '[dbo].[title]'
Go

--------------------------------------------------------------------------------------
--Exercise 3
--Write and execute a SELECT statement that
--retrieves the title number and title from the title table for all rows that
--contain the character string "adventures" in the title.
--Use the LIKE operator in your query. 
--Answer_String.sql is a completed script for this procedure.
--------------------------------------------------------------------------------------

select [title_no],[title]
from [title]
where title like '%adventures%'
Go

--------------------------------------------------------------------------------------
--Exercise 4
--Write and execute a SELECT statement that retrieves the member numbers and assessed fines
--from the loanhist table for all members who have had fines between $8.00 and $9.00. 
--You can execute the sp_help system stored procedure for the loanhist table to find the correct column names.
--Answer_Range.sql is a completed script for this procedure.
--------------------------------------------------------------------------------------

select [member_no],[fine_assessed],[due_date]
from [dbo].[loanhist]
where [fine_assessed] between 8 and 9
Go

--------------------------------------------------------------------------------------
--Exercise 5
--Write and execute a SELECT statement that retrieves the title number and author
--from the title table for all books authored by Charles Dickens or Jane Austen.
--Use the IN operator as part of the SELECT statement. 
--Answer_InList.sql is a completed script for this procedure.
--------------------------------------------------------------------------------------

select [title_no],[author],[title]
from [dbo].[title]
where [author] in ( 'Charles Dickens' ,'Jane Austen')
Go

--------------------------------------------------------------------------------------
--Exercise 6
--Write and execute a SELECT statement that retrieves
--the member number, assessed fine, and fine paid that
--have unpaid fines from the loanhist table.
--Retrieve rows that have fines entered in the fine_assessed column
-- and that have null values for the fine_paid column. 
--Answer_IsNull.sql is a completed script for this procedure.
--------------------------------------------------------------------------------------

select [member_no],[fine_assessed],[fine_paid]
from [dbo].[loanhist]
where [fine_assessed] > 0 and [fine_paid] is null
Go

--------------------------------------------------------------------------------------
--Manipulating Result Sets
--------------------------------------------------------------------------------------
--Exercise 1
--Write and execute a query that retrieves a sorted list of all titles from the title table. 
--Answer_Sort.sql is a completed script for this procedure.
--------------------------------------------------------------------------------------

select [title]
from [dbo].[title]
order by [title]
Go

--------------------------------------------------------------------------------------
--Exercise 2
--Write and execute a query that retrieves all of the unique pairs of cities and states from the adult table. 
--You should receive only one row in the result set for each city and state pair. 
--Answer_Duplicates.sql is a completed script for this procedure.
--------------------------------------------------------------------------------------

select distinct [city],[state]
from [dbo].[adult]
order by [city]
Go

--------------------------------------------------------------------------------------
--Exercise 3.
--(a)
--Write and execute a query that retrieves the member_no, isbn, and fine_assessed columns 
--from the loanhist table of all archived loans a non-null value in the fine_assessed column.
--(b)
--Create a computed column that contains the value of the fine_assessed column multiplied by two.
--(c)
--Use the column alias 'double fine' for the computed column.
--Enclose the column alias within single quotation marks because
--it does not conform to the SQL Server object naming conventions.
--------------------------------------------------------------------------------------

select [member_no],[isbn],[fine_assessed],[fine_assessed] * 2 as 'double fine'
from [dbo].[loanhist]
where [fine_assessed] > 0
Go

--------------------------------------------------------------------------------------
--Exercise 5.
--Write and execute a query that lists all members in the member table with the last name Anderson.
--Format the result set in lowercase characters and display a single column of e-mail names that 
--consists of the member's first name, middle initial, and first two letters of the last name. 
--Answer_Formatting.sql is a completed script for this procedure.
--(a)	Write and execute a query that generates a single column that 
--contains the firstname, middleinitial, and lastname columns from the member table
-- for all members with the last name Anderson.
--(b)	Use the column alias email_name.
--(c)	Modify the query to return a list of e-mail names with 
--the member's first name, middle initial, and first two letters of the last name in lowercase characters.
--Use the SUBSTRING function to retrieve part of a string column.
--Use the LOWER function to return the result in lowercase characters.
--Use the addition (+) operator to concatenate the character strings
--------------------------------------------------------------------------------------
use Library

select lower([firstname]+[middleinitial]+substring([lastname],1,2)) as 'e-mail'
from [dbo].[member]
where lastname = 'Anderson'
Go
--------------------------------------------------------------------------------------
--Exercise 4.
--Format the result set of a query for readability by using the CONVERT function and string literals. 
--Answer_Literals.sql is a completed script for this procedure.
--Write and execute a query that retrieves the title and title_no columns 
--from the title table. Your result set should be a single column with the following format: 
--The title is: Poems, title number 7
--This query returns a single column based on an expression that concatenates four elements:
--a.	The title is: string constant 
--b.	title.title column 
--c.	title number string constant 
--d.	title.title_no column 
--e.	Use the CONVERT function to format the title.title_no column and the addition (+) operator to
--concatenate the character strings.
--------------------------------------------------------------------------------------

select 'The title is: '+[title]+', title number '+convert(varchar,[title_no])
from [dbo].[title]
