Greetings Grasshopper!
Using only SQL, write a query that returns all rows in the custid, custname, and custstate columns from the customers table.

Table Description for customers:
Column	Data Type	Size	Sample
custid	integer	8	4
custname	string	50	Anakin Skywalker
custstate	string	50	Tatooine
custard	string	50	R2-D2


-----------------------------------------------------------------------

/*
For this challenge you need to create a simple DISTINCT statement, 
you want to find all the unique ages.

people table schema:
id
name
age

select table schema:
age (distinct)
*/

SELECT DISTINCT
age
FROM people
