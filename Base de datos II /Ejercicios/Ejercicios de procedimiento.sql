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
