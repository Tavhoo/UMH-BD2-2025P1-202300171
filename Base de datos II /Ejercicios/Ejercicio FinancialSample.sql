use my_db;


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
    
    update currencies set exchange_rate= 20.48 where currency_id=5;
    
select Segment, Country, Product, Sales, Profit, Sales*25 sales_HN FROM financialsample
	where product= " Amarilla " and Segment = "Channel Partners" and Country= "Mexico";
    
	select * from financialsample;
    
select t1.country, t1.product, t1.saleprice, t1.manufacturingprice, t2.exchange_rate
	from financialsample as t1
		inner join currencies as t2
			on t1.Country=t2.Country
				where t1.Country="Mexico" and MonthName in (" January ", " February ") and Year=2014
					order by Product, Date;

select * from currencies;

DELIMITER //
DROP PROCEDURE sp_new_currency; 

DELIMITER //
CREATE procedure sp_new_currency(
	in p_currency_name varchar(45),
    in p_currency_symbol varchar(45), 
    in p_exchange_rate decimal, 
    in p_country varchar(45),
    in p_iso_code varchar(5)
) 
BEGIN  
	set @currency_name = p_currency_name; 
	set @currency_symbol = p_currency_symbol;
	set @exchange_rate = p_exchange_rate;
	set @country = p_country;
    set @iso_code = p_iso_code;

	INSERT INTO currencies (
		currency_name, currency_symbol, exchange_rate, country, ISO_CODE
	)
	VALUES (@currency_name, @currency_symbol, @exchange_rate,  @country, @iso_code);
	commit;  
END;


