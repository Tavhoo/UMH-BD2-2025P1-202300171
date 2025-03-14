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
        
select * from currencies;

DELIMITER //
DROP PROCEDURE sp_upd_currency; 

DELIMITER //
CREATE procedure sp_new_currency(
	in p_currency_name varchar(45),
    in p_currency_symbol varchar(45), 
    in p_exchange_rate decimal(15,6), 
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

call sp_new_currency (
"YEN",
"¥",
0,
"JAPON",
"JPY"
);

DELIMITER //
create procedure sp_upd_currency(
		in p_tasa decimal(15,6),
        in p_currency_id int
)
begin  
		update currencies set exchange_rate = p_tasa
        where currency_id = p_currency_id;
        commit;
end;

call sp_upd_currency(NULL, 9);
    
   update currencies 
   set currency_symbol="¥" 
   where currency_id=9;
    
    delete from currencies 
    where currency_id=12;
    
    select * from currencies;
    

####################################25 de febrero 2024##########################################

select * from currencies b;

#actualizar la tasa solo si, el valor de tasa de cambio es no nulo y es mayor que cero. 
#De lo contrario no hacer cambios
#tasa_cambio > 0 and tasa_cambio is not null
#

DELIMITER //
create procedure sp_upd_IF_currency(
		in p_tasa decimal(15,6),
        in p_currency_id int
)
begin  
		if p_currency_id > 0 and p_tasa > 0 and p_tasa is not null then
        update currencies set exchange_rate = p_tasa
        where currency_id = p_currency_id;
        commit;
      else 
		select "No se puede actualizar";
        
	end if;
end;

call sp_upd_if_currency(150, 9);

select * from currencies;

######################27 de febrero 2025########################

DELIMITER //
CREATE procedure sp_new_currency_case(
	in p_currency_name varchar(45),
    in p_currency_symbol varchar(45), 
    in p_exchange_rate decimal(15,6), 
    in p_country varchar(45),
    in p_iso_code varchar(5)
) 
BEGIN  
	declare v_currency_name varchar(45) default null; 
	declare v_currency_symbol varchar(45);
	declare v_exchange_rate decimal(15,6);
	declare v_country varchar(45);
    declare v_iso_code varchar(5);
    
    
    set v_currency_name = p_currency_name; 
	set v_currency_symbol = p_currency_symbol;
	set v_exchange_rate = p_exchange_rate;
	set v_country = p_country;
    set v_iso_code = p_iso_code;
    
    CASE 
		when p_currency_name like "%dolar%" then
			set v_currency_symbol = "$";
		when p_currency_name like "%peso%" then
			set v_currency_symbol = "P";
		when p_currency_name like "%yen%" then
			set v_currency_symbol = "¥";
		when p_currency_name like "%euro%" then
			set v_currency_symbol = "€";
		else
			set v_currency_symbol = p_currency_symbol;
            
		end case;
        
        
	INSERT INTO currencies (
		currency_name, currency_symbol, exchange_rate, country, ISO_CODE
	)
	VALUES (v_currency_name,v_currency_symbol, v_exchange_rate,  v_country, v_iso_code);
	commit;  
END;

call sp_new_currency_case ("euro", "eu", 0, "Alemania", "EUR");

call sp_new_currency_case_variable (
"sol peruano",
"s",
0,
"PERU",
"PEN"
);

DELIMITER //
DROP PROCEDURE sp_new_currency_case; 
    

    delete from currencies 
    where currency_id=10;
    
     select * from currencies;
     
     
###################3/3/2025#########################
set @variable=0;
declare variable varchar(5);

DELIMITER //
DROP PROCEDURE sp_new_currency_case_variable; 

DELIMITER //
CREATE procedure sp_new_currency_case_variable(
	in p_currency_name varchar(45),
    in p_currency_symbol varchar(45), 
    in p_exchange_rate decimal(15,2), 
    in p_country varchar(45) ,
    in p_iso_code varchar(45)
) 
BEGIN  
	/*	Declaracion de variables	*/
	DECLARE v_currency_name 	varchar(45) default null;
	DECLARE v_currency_symbol	varchar(45);
	DECLARE v_exchange_rate		decimal(15,2);
	Declare v_country 			varchar(45);
    declare v_iso_code 			varchar(45) default null;  
	
    set v_currency_name = p_currency_name; 
	set v_currency_symbol = p_currency_symbol;
	set v_exchange_rate = p_exchange_rate;
	set v_country = p_country; 
    /*	Case statement	*/
	CASE 
		WHEN p_currency_name LIKE '%dolar%' THEN  set v_currency_symbol = "$";
		WHEN p_currency_name LIKE '%peso%' THEN  set v_currency_symbol = "P";
		WHEN p_currency_name LIKE '%yen%' THEN  set v_currency_symbol = "¥";
		WHEN p_currency_name LIKE '%euro%' THEN  set v_currency_symbol = "€";  
        ELSE set v_currency_symbol = p_currency_symbol;
	END CASE; 
    
    /* Consultando si existe un valor en la tabla para el campo ISO_CODE */
    select iso_code into v_iso_code from currencies 
    where iso_code = p_iso_code;
    
    /*si la variable es nula,significa que el valor no existe en la tabla y por tanto podemos
      realizar una nueva insercion*/
    IF LENGTH(v_iso_code) = 0 or v_iso_code is null then  
		set v_iso_code = p_iso_code;         
		INSERT INTO currencies ( currency_name, currency_symbol, exchange_rate, country, ISO_CODE )
		VALUES (v_currency_name, v_currency_symbol, v_exchange_rate,  v_country, v_iso_code);
		commit; 
	END IF;
END;


CALL sp_new_currency_case_variable(
	"COLON CONSTARRICENSE", "c",   0,  "COSTA RICA" , "CRC"
); 

select * from currencies where iso_code = 'CRC';

set @isovar = "";
select iso_code into @isovar from db_demo.currencies where iso_code = 'CRC';
select @isovar;

