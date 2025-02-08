use proyecto;
select * from financialsample;

create table currencies (
	currency_id INT auto_increment primary key,
    currency_name varchar(100) not null,
    currency_symbol varchar(10),
    iso_code varchar(5) not null,
    exchange_rate decimal(15, 6), 
    created_ad timestamp default current_timestamp,
    country varchar(45)
); 

select * from currencies;

insert into currencies (currency_name, currency_symbol, iso_code, exchange_rate, country)
values
	("Canadian Dollar", "CAD$", "CAD", null, "CANADA"),
    ("Euro", "€", "EUR", null, "FRANCE"),
    ("Euro", "€", "EUR", null, "GERMANY"),
    ("US Dollar", "$", "USD", null, "UNITED STATES OF AMERICA"),
    ("Mexican Peso", "$", "MXN", null, "MEXICO");
    
    update proyecto.currencies set exchange_rate= 20.48 where currency_id=5;
    
select Segment, Country, Product, Sales, Profit, Sales*25 sales_HN FROM proyecto.financialsample
	where product= " Amarilla " and Segment = "Channel Partners" and Country= "Mexico";
    
	select * from financialsample;
    
select t1.country, t1.product, t1.saleprice, t1.manufacturingprice, t2.exchange_rate
	from proyecto.financialsample as t1
		inner join proyecto.currencies as t2
			on t1.Country=t2.Country
				where t1.Country="Mexico" and MonthName in (" January ", " February ") and Year=2014
					order by Product, Date;
        
    
    
    
    
    