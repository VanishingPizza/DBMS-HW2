 /*Task: 
Write a SQL query to answer each of the following:

1.Average Price of Foods at Each Restaurant
2.Maximum Food Price at Each Restaurant
3.Count of Different Food Types Served at Each Restaurant
4.Average Price of Foods Served by Each Chef
5.Find the Restaurant with the Highest Average Food Price 

6. Extra Credit: Determine which chef has the highest average price of the foods served at the restaurants where they work. Include the chef’s name, the average food price, and the names of the restaurants where the chef works. 
Sort the  results by the average food price in descending order. */

-- Query 1: Finding the average price of foods at each restaurant

select restaurants.name, avg(foods.price) as avgprice
from restaurants  inner join serves on(restaurants.restID = serves.restID)
				   inner join foods on (foods.foodID = serves.foodID)
group by restaurants.name
order by avgprice;


-- Query 2: Finding the maximum food price at each restaurant

select restaurants.name, max(foods.price) as MaxPrice
from restaurants inner join serves on (restaurants.restID = serves.restID)
				inner join foods on (foods.foodID = serves.foodID)
group by restaurants.name
order by max(foods.price);

-- Query 3: Counting the different food types served at each restaurant

select restaurants.name, count(foods.type) as Types_Served
from restaurants cross join serves
				cross join foods
where restaurants.restID = serves.restID and foods.foodID = serves.foodID
group by restaurants.name;
                
-- Query 4: Finding average price of foods served by each chef

select chefs.name, avg(foods.price) as AVGPrice
from chefs inner join works using(chefID)
		   inner join serves using(restID)
		   inner join foods using(foodID)
group by chefs.name
order by AVGPrice;

-- Query 5: Finding the restaurant with the highest average food price

select restaurants.name, avg(foods.price)
from restaurants  inner join serves on(restaurants.restID = serves.restID)
				   inner join foods on (foods.foodID = serves.foodID)
group by restaurants.name
having avg(foods.price) >=all
		(Select avg(foods.price)
		from restaurants  inner join serves on(restaurants.restID = serves.restID)
						  inner join foods on (foods.foodID = serves.foodID)
						  group by restaurants.name);
