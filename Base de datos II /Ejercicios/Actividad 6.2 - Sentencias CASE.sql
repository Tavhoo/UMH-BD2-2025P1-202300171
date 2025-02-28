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
