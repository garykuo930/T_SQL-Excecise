use AdventureWorks
Go

with Managers as
(
select [EmployeeID], [ManagerID], 1 as level
from  [HumanResources].[Employee]
where [ManagerID] is null
union all
select emp.[EmployeeID], emp.[ManagerID], level + 1
from [HumanResources].[Employee] emp
join Managers
on emp.[ManagerID] = Managers.[EmployeeID]
)
select * from Managers
order by level,ManagerID