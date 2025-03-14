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
