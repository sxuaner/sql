DROP TABLE IF EXISTS PizzaCompany;

CREATE TABLE PizzaCompany
(
  CompanyId decimal PRIMARY KEY,
  CompanyName varchar(50) ,
  CompanyCity varchar(30)  
);


INSERT INTO PizzaCompany (CompanyId, CompanyName, CompanyCity) VALUES(1,'Dominos','Los Angeles') ;
INSERT INTO PizzaCompany (CompanyId, CompanyName, CompanyCity) VALUES(2,'Pizza Hut','San Francisco') ;
INSERT INTO PizzaCompany (CompanyId, CompanyName, CompanyCity) VALUES(3,'Papa johns','San Diego') ;
INSERT INTO PizzaCompany (CompanyId, CompanyName, CompanyCity) VALUES(4,'Ah Pizz','Fremont') ;
INSERT INTO PizzaCompany (CompanyId, CompanyName, CompanyCity) VALUES(5,'Nino Pizza','Las Vegas') ;
INSERT INTO PizzaCompany (CompanyId, CompanyName, CompanyCity) VALUES(6,'Pizzeria','Boston') ;
INSERT INTO PizzaCompany (CompanyId, CompanyName, CompanyCity) VALUES(7,'chuck e cheese','Chicago') ;
 
SELECT * FROM PizzaCompany;


CREATE TABLE Foods
(
ItemId decimal  PRIMARY KEY, 
 ItemName  Varchar(50), 
 UnitsSold int,
 CompanyID int

 -- FOREIGN KEY(CompanyID) REFERENCES PizzaCompany(CompanyID)
 );
INSERT INTO Foods (ItemId, ItemName, UnitsSold, CompanyId) VALUES(1,'Large Pizza',5,2);
INSERT INTO Foods (ItemId, ItemName, UnitsSold, CompanyId) VALUES(2,'Garlic Knots',6,3);
INSERT INTO Foods (ItemId, ItemName, UnitsSold, CompanyId) VALUES(3,'Large Pizza',3,3);
INSERT INTO Foods (ItemId, ItemName, UnitsSold, CompanyId) VALUES(4,'Medium Pizza',8,4);
INSERT INTO Foods (ItemId, ItemName, UnitsSold, CompanyId) VALUES(5,'Breadsticks',7,1);
INSERT INTO Foods (ItemId, ItemName, UnitsSold, CompanyId) VALUES(6,'Medium Pizza',11,1);
INSERT INTO Foods (ItemId, ItemName, UnitsSold, CompanyId) VALUES(7,'Small Pizza',9,6);
INSERT INTO Foods (ItemId, ItemName, UnitsSold, CompanyId) VALUES(8,'Small Pizza',6,7);
 
SELECT * FROM Foods;