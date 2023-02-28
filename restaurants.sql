-- For uploading data to powerbi.
use restaurants;
select * from restaurants;

create database restaurants;

-- I. Loading Tables 
	-- There are total 5 tables.

-- II. Looking at the first five rows of all the tables.
	-- 1. Consumer_preferences
	select *
	from restaurants.consumer_preferences
	limit 5;
	-- This tables have Conumer_Id and there cuisine
	-- The column name needs tobe changed
	Alter table restaurants.consumer_preferences
	rename column ï»¿Consumer_ID to Consumer_ID ;

	-- 2. Consumers 
	select *
	from restaurants.consumers
	limit 5;
	-- This tables gives info related to consumers.
	-- Same changes needed for this table
	Alter table restaurants.consumers
	rename column ï»¿Consumer_ID to Consumer_ID ;
    

	-- 3. Ratings
	select *
	from restaurants.ratings
	limit 5;
	-- This table contain info related to conumers raing to each restaurant.
	-- Changes in column name
	Alter table restaurants.ratings
	rename column ï»¿Consumer_ID to Consumer_ID;

	-- 4. Restaurants_cuisines
	select *
	from restaurants.restaurant_cuisines
	limit 5;

	Alter table restaurants.restaurant_cuisines
	rename column ï»¿Restaurant_ID to Restaurant_ID;

	-- 5. Restaurants.
	select *
	from restaurants.restaurants
	limit 5;
 
-- III. Joining the tables
	-- 1. Joining resturants and restaurant_cuisines
	select count(*)  
	from restaurants.restaurant_cuisines;
	-- 112 Records
	select count(*)
	from restaurants.restaurants;
	-- 130 records
	-- Thus, left join would help

	ALTER TABLE restaurants.restaurants ADD COLUMN Cuisine varchar(50) DEFAULT 0;
	update restaurants.restaurants as rest
	left join restaurants.restaurant_cuisines as cuis
	on rest.Restaurant_ID = cuis.Restaurant_ID
	set rest.Cuisine = cuis.Cuisine; 

-- 2. Joining consuumers and consumers_prefernces
	Alter table restaurants.consumers ADD column Preferred_Cuisine char(30) Default 0;
	update restaurants.consumers as cons
	left join restaurants.consumer_preferences as pref
	on cons.Consumer_ID = pref.Consumer_ID
	set cons.Preferred_Cuisine = pref.Preferred_Cuisine;
     
-- III. Looking for missing values (0 or NA or null) in each table 
	-- 1. Lets look at the resturants table for missing values.
	select *
	from restaurants.restaurants;
	-- There are null values in the Cuisine column.
	-- Lets check total null values.
	SELECT sum(case when Cuisine is null then 1 else 0 end) total_null 
	FROM restaurants.restaurants 
	WHERE Cuisine IS NULL;

    
    -- 2. Consumers table 
    select *
    from restaurants.consumers
    where coalesce(City, State, Country, Smoker, Drink_Level, Transportation_Method,
    Marital_Status, Children, Occupation, Budget, Preferred_Cuisine, age_bins) =  '';
    
    -- There are blank values in Smoker, Transportation_method, Marital_Status, Children, Occupation and Budget.
    -- Lets fill the missing values.
    -- We will fill the missing values using the mode of features.
    
    select smoker
    from restaurants.consumers
    group by smoker
    order by count(*) desc
    limit 1;
    
    select smoker, consumer_id 
    from restaurants.consumers
    where smoker = '';

        
-- IV. Filling missing values (wherever possible)
	-- Because it's a real dataset and only 35 restaurant cuisines are missing we can fill that manually.
    select *
    from restaurants.restaurants
    where Cuisine is Null
    order by name;
	
    -- 1. For Carnitas Mata  Calle 16 de Septiembre
    UPDATE restaurants.restaurants
	SET Cuisine = 'Fast Food'
	WHERE Name = 'Carnitas Mata  Calle 16 de Septiembre';
    
    -- 2. For Chilis Cuernavaca
	UPDATE restaurants.restaurants
	SET Cuisine = 'American'
	WHERE Name = 'Chilis Cuernavaca';
    
    -- 3. For Church's
    UPDATE restaurants.restaurants
	SET Cuisine = 'American'
	WHERE Name = "Church's";

	-- 4. For Dairy Queen
    UPDATE restaurants.restaurants
	SET Cuisine = 'Fast Food'
	WHERE Name = 'Dairy Queen';
    
    -- 5. For Don Burguers
    UPDATE restaurants.restaurants
	SET Cuisine = 'Fast Food'
	WHERE Name = 'Don Burguers';
    
    -- 6. For Giovannis
    UPDATE restaurants.restaurants
	SET Cuisine = 'Italian'
	WHERE Name = 'Giovannis';

    -- 7. for La Estrella De Dimas
	UPDATE restaurants.restaurants
	SET Cuisine = 'Mexican'
	WHERE Name = 'La Estrella De Dimas';

	-- 8. for Los Toneles
	UPDATE restaurants.restaurants
	SET Cuisine = 'International'
	WHERE Name = 'Los Toneles';
    
    -- 9. for Los Vikingos
	UPDATE restaurants.restaurants
	SET Cuisine = 'Mexican'
	WHERE Name = 'Los Vikingos';
    
    -- 10. for Potzocalli
	UPDATE restaurants.restaurants
	SET Cuisine = 'Mexican'
	WHERE Name = 'Potzocalli';
    
    -- 11. for Restaurant Los Compadres
	UPDATE restaurants.restaurants
	SET Cuisine = 'Mexican'
	WHERE Name = 'Restaurant Los Compadres';
    
    -- 12. for Restaurant Los Pinos
	UPDATE restaurants.restaurants
	SET Cuisine = 'International'
	WHERE Name = 'Restaurant Los Pinos';
    
    -- 13. for Restaurant Teely
	UPDATE restaurants.restaurants
	SET Cuisine = 'International'
	WHERE Name = 'Restaurant Teely';
    
	-- 14. For Restaurante 75 
	UPDATE restaurants.restaurants
	SET Cuisine = 'Fast Food'
	WHERE Name = 'Restaurante 75';
    
    -- 15. For Restaurante El Cielo Potosino
	UPDATE restaurants.restaurants
	SET Cuisine = 'Latin'
	WHERE Name = 'Restaurante El Cielo Potosino';
    
    -- 16. For Restaurante Guerra
	UPDATE restaurants.restaurants
	SET Cuisine = 'International'
	WHERE Name = 'Restaurante Guerra';

    -- 17. For Restaurante La Estrella De Dima
	UPDATE restaurants.restaurants
	SET Cuisine = 'American'
	WHERE Name = 'Restaurante La Estrella De Dima';

    -- 18. For Restaurante La Gran Via
	UPDATE restaurants.restaurants
	SET Cuisine = 'International'
	WHERE Name = 'Restaurante La Gran Via';
    
     -- 19. For Rincon Huasteco
	UPDATE restaurants.restaurants
	SET Cuisine = 'Latin'
	WHERE Name = 'Rincon Huasteco';
    
     -- 20. For Rincon Del Bife
	UPDATE restaurants.restaurants
	SET Cuisine = 'International'
	WHERE Name = 'Rincon Del Bife';
    
     -- 21. For Sanborns Casa Piedra
	UPDATE restaurants.restaurants
	SET Cuisine = 'Mexican'
	WHERE Name = 'Sanborns Casa Piedra';

     -- 22. For Sirloin Stockade
	UPDATE restaurants.restaurants
	SET Cuisine = 'Mexican'
	WHERE Name = 'Sirloin Stockade';
    
    -- 23. For Vips
	UPDATE restaurants.restaurants
	SET Cuisine = 'Mexican'
	WHERE Name = 'Vips';    
	-- There are still 12 missing values 
	-- We will keep them as it is.


	-- Let's fill the value for consumers table:
    -- 1. filling smoker column
	select smoker
	from restaurants.consumers
	group by smoker
	order by count(*) desc
	limit 1;
    
	update restaurants.consumers
    set smoker = 'No' 
	where smoker = '';
    
    -- 2. Filling Transportation_Method
	select transportation_method
	from restaurants.consumers
	group by transportation_method
	order by count(*) desc
	limit 1;
    
	update restaurants.consumers
    set Transportation_method = 'Public' 
	where Transportation_Method = '';
    
    -- 3. Filling Marital_Status
	select marital_status
	from restaurants.consumers
	group by marital_status
	order by count(*) desc
	limit 1;    
    
	update restaurants.consumers
    set marital_status = 'Single'
	where marital_status = '';
    
    -- 4. Filling Chidren column
    select children
    from restaurants.consumers
    group by children
    order by count(*) desc
    limit 1;
    
    update restaurants.consumers
    set children = 'Independent'
    where children = '';
    
    -- 5. Filling Occupation column
    select Occupation
    from restaurants.consumers
    group by Occupation
    order by count(*) desc
    limit 1;
    
    update restaurants.consumers
    set occupation = 'Student'
    where occupation = '';    
    
    -- 6. Filling Budget Column
    select Budget
    from restaurants.consumers
    group by budget
    order by count(*) desc
    limit 1;
    
    update restaurants.consumers
    set budget = 'Medium'
    where budget = '';   


-- V. Answering Queries:
	-- 1. how many consumers and restaurants are present in this table.
	select count(distinct consumer_id) as total_consumers
	from restaurants.consumer_preferences;
	-- 138 consumers
	select count(distinct Restaurant_ID) as total_restaurants
	from restaurants.restaurants;
	-- 130 Restaurants

	-- 2. how many consumers % rated 1,2,0 by area.
	-- To solve it we will join consumers and ratings
	select *
	from restaurants.consumers c
	join restaurants.ratings r
	on c.consumer_id = r.consumer_id;
	-- At many places same consumer have rated differennt restaurants
	with sub as(
		select r.overall_rating as ratings, count(c.consumer_id) as total_consumers
		from restaurants.ratings as r
		join restaurants.consumers as c
		on r.Consumer_ID = c.Consumer_ID
		group by 1)
	select ratings, total_consumers, total_consumers*100/t.s as percent_total
	from sub
	cross join (select sum(total_consumers) as s from sub) t;

	-- 3. how many restaurant % rated 1,2,0 by area
	-- We will join restaurants and ratings
	-- There are only 130 unique restaurants and 1160 ratings records, we will take avg rating for each restaurant.
	with rest_rat as(
		select restaurant_id, avg(overall_rating) as avg_rating
		from restaurants.ratings
		group by 1
		order by 1),
	total_rest_rat as(select rr.avg_rating, count(rr.avg_rating) as total_rest, r.city, r.state, r.country
	from restaurants.restaurants as r
	join rest_rat as rr
	on r.restaurant_id = rr.restaurant_id
	group by 3,4,5)
	select country, state, city, avg_rating, total_rest, total_rest*100/r.s as total_rest_percent
	from total_rest_rat
	cross join (select sum(total_rest) as s from total_rest_rat)r
	order by avg_rating desc, total_rest desc;
	 -- we can see uneven sample of restaurant numbers ths may suggest a sampe bias.
	 
	-- 4. Age distribution of consumers
	Alter table restaurants.consumers add column age_bins varchar(30);
	update restaurants.consumers
	set age_bins = case when age>=18 and age <= 28 then "18-28" 
						when age >= 29 and age <= 30 then "29-39"
						when age >= 40 and age <= 50 then "40-50"
						when age >= 51 and age <= 61 then "51-61"
						when age >= 62 and age <= 72 then "62-72"
						else "above 70" end;
	select age_bins, count(*) as consumer_dist
	from restaurants.consumers
	group by 1;
	-- Many consumers are from genz and less numbers are from other age groups.

	-- 5. Transportation of consumers
	select transportation_method, count(*) as consumers_travel_method
	from restaurants.consumers 
	group by 1
	order by 2 desc;
	-- majority of the population uses public transportation.

	-- 6. smoking and drinking level of conusmers
	select smoker, count(*) as smokers_count
	from restaurants.consumers
	group by 1
	order by 2 desc;
	-- Majority of them don't smoke.
	select drink_level, count(*) as drinkers_range
	from restaurants.consumers
	group by 1
	order by 2 desc;
	-- Populations drinks moderately and not very fond of drinking.

	-- 7. Cuisines served in restaurants and ratings
	select r.cuisine, count(distinct r.Restaurant_ID) as no_of_rest, avg(rr.overall_rating) as avg_rating
	from restaurants.restaurants r
	join restaurants.ratings as rr
	on r.restaurant_id = rr.restaurant_id
	group by 1
	order by 2 desc, 3 desc;
	-- Mexican cuisine is served in most restaurant with very good average ratings.

	-- 8. Consumers preferred cuisines 
	select Preferred_Cuisine, count(*) as total_count, count(*)*100/r.c as cuisine_percent
	from restaurants.consumer_preferences
	cross join (select count(*) as c from restaurants.consumer_preferences)r 
	group by 1
	order by 3 desc;
	-- Mexican is most preferred cuisine.

	-- 9. Consumers earning.
	select budget, count(consumer_id) as total_consumers 
	from restaurants.consumers 
	group by 1;
	-- most of them are medium range earners.

	-- 10. Restaurant price range.
	select price, count(*) as total_count
	from restaurants.restaurants
	group by 1;
	-- Most of the restaurants also have medium price ranges.

