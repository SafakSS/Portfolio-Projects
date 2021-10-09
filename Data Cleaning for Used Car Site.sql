USE Car
Select * FROM CARS


-- Step 1 : Price Column -------------------------------------------------------------------------------------------------------
Select * From Cars

Delete From Cars
Where Price not like '%TL%' 

Delete From Cars
Where Price < 5000

Update Cars
Set Price = REPLACE(Price,'TL','')

Update Cars
Set Price = REPLACE(Price,'.','')

Update Cars
Set Price = TRIM(Price)

Select DISTINCT(Price),COUNT(Price) FROM CARS
Group By Price
Order By Price ASC

Delete From Cars
Where Price is null

Select * From CARS




-- Step 2 : Brand Column -------------------------------------------------------------------------------------------------------
Select * From CARS

Update CARS
Set Brand = TRIM(Brand)

Select DISTINCT(Brand),COUNT(Brand) FROM CARS
Group By Brand
Order By Brand ASC




-- Step 3 : Series Column -------------------------------------------------------------------------------------------------------
Select * From CARS

Update CARS
Set Series = TRIM(Series)

Select DISTINCT(Series),COUNT(Series) FROM CARS
Group By Series
Order By Series ASC


-- Step 4 : Model Column -------------------------------------------------------------------------------------------------------
Select * From CARS

Update CARS
Set Model = TRIM(Model)



-- Step 5 : Fuel_Type Column -------------------------------------------------------------------------------------------------------
Select * From CARS
Update CARS
Set Fuel_Type = TRIM(Fuel_Type)

Select DISTINCT(Fuel_Type),COUNT(Fuel_Type) FROM CARS
Group By Fuel_Type
Order By Fuel_Type ASC

Delete From Cars
Where Fuel_Type like '%km%'



-- Step 6 : Gear_Type Column -------------------------------------------------------------------------------------------------------
Select * From CARS

Select DISTINCT(Gear_Type),COUNT(Gear_Type) FROM CARS
Group By Gear_Type
Order By Gear_Type ASC
	
Update Cars
Set Gear_Type = REPLACE(Gear_Type,'DÃ¼z','Manuel')

Update Cars
Set Gear_Type = REPLACE(Gear_Type,'YarÄ± Otomatik','Yari Otomatik')

Update Cars
Set Gear_Type = TRIM(Gear_Type)



-- Step 6 :Kilometer Column -------------------------------------------------------------------------------------------------------
Select * From Cars
Where Kilometer is null


Update Cars
Set Kilometer = Engine_Power
Where Kilometer not like '%km%' and Engine_Power like '%km%' 

Update Cars
Set Kilometer = Engine_Power
Where Kilometer is NULL and Engine_Power like '%km%' 

Update Cars
Set Kilometer = Engine_Capacity
Where Kilometer not like '%km%' and Engine_Capacity like '%km%' 


Update Cars
Set Kilometer = REPLACE(Kilometer,'km','')

Update Cars
Set Kilometer = REPLACE(Kilometer,'.','')

Select DISTINCT(Kilometer),COUNT(Kilometer) FROM CARS
Group By Kilometer
Order By Kilometer ASC

Delete From Cars
Where Kilometer is null

Update Cars
Set Kilometer = TRIM(Kilometer)


-- Step 7 :Engine_Power Column -------------------------------------------------------------------------------------------------------
Select * From Cars
Where Engine_Power  like '%kadar%'

Delete From Cars
Where Engine_Power  like '%zeri%'

Delete From Cars
Where Engine_Power  like '%kadar%'

Update Cars
Set Engine_Power = Engine_Capacity
Where Engine_Power not like '%hp%' and Engine_Capacity like '%hp%' 

Delete From Cars
Where Engine_Power not like '%hp%'

Update Cars
Set Engine_Power = REPLACE(Engine_Power,'hp','HP')

Select DISTINCT(Engine_Power),COUNT(Engine_Power) FROM CARS
Group By Engine_Power
Order By Engine_Power ASC

Delete From Cars
Where Engine_Power is null

Update Cars
Set Engine_Power = TRIM(Engine_Power)


-- Step 7 :Engine_Capacity Column -------------------------------------------------------------------------------------------------------
Select * FRom Cars
Select DISTINCT(Engine_Capacity),COUNT(Engine_Capacity) FROM CARS
Group By Engine_Capacity
Order By Engine_Capacity ASC

Select * From Cars
Where Engine_Capacity like '%kadar%'

Update Cars
Set Engine_Capacity = REPLACE(Engine_Capacity,'cm3','cc')

Select * From Cars
Where Engine_Capacity like '%HP%'
Order by Year_


Update a
Set a.Engine_Capacity = b.Engine_Capacity
From Cars a
Join Cars b
on a.Ad_Number <> b.Ad_Number AND a.Series = b.Series and a.Model=b.Model and a.Year_=b.Year_ and a.Gear_Type = b.Gear_Type and a.Engine_Power=b.Engine_Power
and a.Engine_Capacity like '%HP%' and b.Engine_Capacity like '%cc%'

-- Ortak arabalarýn eksik kolonlarýný doldurduk.

Delete  from Cars
Where Engine_Capacity like '%HP%'

Update Cars
Set Engine_Capacity = TRIM(Engine_Capacity)


Select * FRom Cars


Select DISTINCT(Engine_Capacity),COUNT(Engine_Capacity) FROM CARS
Group By Engine_Capacity
Order By Engine_Capacity ASC


Update a
Set a.Engine_Capacity = b.Engine_Capacity
From Cars a
Join Cars b
on a.Ad_Number <> b.Ad_Number AND a.Series = b.Series and a.Model=b.Model and a.Year_=b.Year_ and a.Gear_Type = b.Gear_Type and a.Engine_Power=b.Engine_Power and a.Fuel_Type=b.Fuel_Type
and a.Engine_Capacity like '-' and b.Engine_Capacity like '%cc%'

Select * From Cars
Where Engine_Capacity like '-'

Delete From Cars
Where Engine_Capacity like '-'


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Gereksiz kolonlarý silme iþlemi :
ALTER TABLE Cars DROP COLUMN Ad_Number
ALTER TABLE Cars DROP COLUMN Date_
ALTER TABLE Cars DROP COLUMN Chassis_Number
ALTER TABLE Cars DROP COLUMN Plate_Number
ALTER TABLE Cars DROP COLUMN Painting_Changing
ALTER TABLE Cars DROP COLUMN From_Who



Select * From Cars
Order by 2,3,4,5,6,7,8,9,10,1