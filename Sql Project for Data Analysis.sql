SELECT * from books
Select * from Customers
select * from orders

-- BASIC QUSTION

-- 1) Retrive all the books int the 'Fiction' Genre
select * from books
where Genre = 'Fiction'

-- 2) Find Books Published after the 1950
select * from books
where Published_Year > 1950

-- 3) List all Customers from the Canada
select * from Customers
where Country = 'Canada'

-- 4) Show Orders Placed in the Novemver 2023
select * from orders
where Order_Date between '2023-11-01' and '2023-11-30'

-- 5) Retrive the total stock of books available
select sum(Stock) as Total_Stock
from books

-- 6) Find the Details of the most expensive books
select *  from dbo.books
where Price = (select max(Price) from dbo.books)


-- 7) Show all customers who ordered more than 1 quantity of a book
select * from orders
where Quantity > 1

-- 8) Retrive all orders where the total amount exceeds $20
select * from Orders
where Total_Amount > 20


-- 9) List all the genres available in the books table
select distinct Genre from Books

-- 10) find the books with the lowest stock
select top 1 *  from Books
order by Stock 

-- 11) Calculate the total revenue generated from all orders
select sum(Total_Amount) as TotalRevenue
from orders

-- ADVANCED QUESTION

-- 1) Retrive the total number of books sold for each genre
select b.Genre, sum(o.Quantity) as TotalBooks_Sold
from Books b 
join Orders o on o.Book_ID = b.Book_ID
group by b.Genre


-- 2) Find the average price of books in the "Fanatasy" Genre:
select avg(Price) as AvgPrice
from Books
where Genre = 'Fantasy'

-- 3) List Customer_ID and Name	 who have placed at least 2 orders
select C.Name, C.Customer_ID, count(O.Order_ID) as Orders
from orders O
JOIN Customers C on C.Customer_ID = O.Customer_ID
group by C.Customer_ID, C.Name
having count(O.Order_ID) >= 2

-- 4) Find the most frequently ordered book:
select top 1 B.Title, O.Book_ID, count(O.Order_ID) AS OrderdBook
from Orders O
join Books B on B.Book_ID = O.Book_ID
group by O.Book_ID, B.Title
order by OrderdBook desc

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre
select top 3 * from Books
where Genre = 'Fantasy'
order by Price Desc

-- 6) Retrieve the total Quantity of books sold by each author
select B.Author, sum(O.Quantity) as Total_Books_Sold
from Books B
join Orders O on B.Book_ID = O.Book_ID
group by B.Author

-- 7) List the cities where customers who spent over $30 are located
select * from Customers

select distinct C.City, Total_Amount
from Orders O
join Customers C on C.Customer_ID = O.Customer_ID
where Total_Amount > 30

-- 8) Find the Customer who spent most on orders
select top 1 C.Name, O.Customer_ID, SUM(O.Total_Amount) as Total_Spent
from Orders O
JOIN Customers C on C.Customer_ID = O.Customer_ID
group by O.Customer_ID, C.Name
order by Total_Spent DESC

-- 9) Calculate the stock remaining after fulfilling all orders
select 
B.Book_ID, 
B.Title, 
B.Stock - ISNULL(sum(O.Quantity), 0) as Remaining_Stock
from Books B
left join Orders O on B.Book_ID = O.Book_ID
group by B.Book_ID, B.Title, B.Stock;