use proyecto;

delimiter //
drop function fn_get_producto

delimiter //
create function fn_get_producto (p_valor1 double, p_valor2 double)
returns double deterministic
begin
	declare producto double;
    
    set producto=p_valor1 + p_valor2;
    return producto;
end;
	
select fn_get_producto(12, 10);

delimiter //
drop function fn_zero_division;

delimiter //
create function fn_zero_division (p_valor1 double, p_valor2 double)
returns double deterministic
begin
	DECLARE DIVISION DOUBLE default 0;
    
    if p_valor2 != 0 then
		set division = p_valor1 / p_valor2;
	end if;
    
    return division;
end;

select fn_zero_division(1, 0);

select 
	exchange_rate,
	(100/exchange_rate) division ,
    fn_zero_division(100, exchange_rate) fn
    from currencies;
    
select * from currencies;
