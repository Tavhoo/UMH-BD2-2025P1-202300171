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

call sp_upd_if_currency(0, 0);

select * from currencies;
