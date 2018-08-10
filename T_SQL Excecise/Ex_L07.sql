--------------------------------------------------------------------------------------
--Exercise 1: Using the INSERT Statement
--------------------------------------------------------------------------------------
--�s�W��Ʀ�item�Aitem���D������
--------------------------------------------------------------------------------------
use Library

insert item([isbn],[title_no],[translation],[cover],[loanable]) 
values (10001,8,'ENGLISH','HARDBACK','Y')

insert item([isbn],[title_no],[translation],[cover],[loanable]) 
values (10101,8,'ENGLISH','SOFTBACK','Y')

select * from item
order by isbn desc
--------------------------------------------------------------------------------------
--�s�W��Ʀ�copy�Acopy���~������
--------------------------------------------------------------------------------------
use Library
insert copy([isbn],[copy_no],[title_no],[on_loan]) 
values (10001,1,8,'N')

select * from copy
order by isbn desc
--------------------------------------------------------------------------------------
-- �ƻs[HumanResources].[Employee]�ܷs��ƪ�[Employee_Copy]
-- #��ܸӸ�ƪ��Ȧs
--------------------------------------------------------------------------------------
use AdventureWorks
select * into #Employee_Copy from [HumanResources].[Employee] 
--------------------------------------------------------------------------------------
--Exercise 2: Using the DELETE Statement
--------------------------------------------------------------------------------------
--Write a query that returns the row from the item table that
--represents a paperback copy (isbn 10101) of The Cherry Orchard (title_no 8).
--------------------------------------------------------------------------------------
use Library
select isbn,title_no
from item
where isbn = 10101
--------------------------------------------------------------------------------------
--	Modify the query from step  the previous procedure so that
--it deletes the row from the item table that represents a paperback copy (isbn 10101) of The Cherry Orchard (title_no 8).
--------------------------------------------------------------------------------------
use Library
delete item where isbn = 10101
--------------------------------------------------------------------------------------
--Exercise 3: Using the UPDATE Statement
--------------------------------------------------------------------------------------
--Write a query that retrieves the last name of member number 507 in the member table. 
--------------------------------------------------------------------------------------
use Library
select lastname
from member
where member_no = 507
--------------------------------------------------------------------------------------
--Write a query that changes the last name of member number 507 in the member table to a different one of your choice. 
--------------------------------------------------------------------------------------
use Library
update member
	set lastname = 'Connor'
	where member_no = 507
--------------------------------------------------------------------------------------
--Exercise 4: Modifying Tables Based on Data in Other Tables
--------------------------------------------------------------------------------------
--�s�W���Q�K�����|���G
--Review and execute the \Labfiles\L07\AddJuvenile.sql script file to add a new juvenile member to the library database. 
--------------------------------------------------------------------------------------
use Library
insert [dbo].[adult]
select juvenile.[member_no],[street],[city],[state],[zip],[phone_no],dateadd(YY,1,getdate())
from [dbo].[adult]
join [dbo].[juvenile]
on adult.member_no = juvenile.adult_member_no
--select * from juvenile
where GETDATE() > DATEADD( YY, 18, [birth_date] )
--------------------------------------------------------------------------------------
--�R�����ƪ��|��
--------------------------------------------------------------------------------------
use Library
delete from [dbo].[juvenile]
--select *
from [dbo].[juvenile]
join [dbo].[adult]
on juvenile.member_no = adult.member_no
--------------------------------------------------------------------------------------