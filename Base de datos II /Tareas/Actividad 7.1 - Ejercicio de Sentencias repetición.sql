use world;
/*
	Calculador de ahorro mensual. 
*/
drop table transacciones; 

/*	Crear una tabla para crear registros */
CREATE TABLE transacciones (
    numTransaccion INT AUTO_INCREMENT PRIMARY KEY,
    Mes int,
    Monto DECIMAL(10, 2),
    Saldo DECIMAL(10, 2)
);

select * from transacciones;

delimiter //
drop procedure sp_simulador_ahorro;

/*	Crear procedimiento almacenado	*/
delimiter //
create procedure sp_simulador_ahorro(
	in p_monto decimal(10,2),
    in p_meses int ,
    in p_tasa_interes decimal(10,2)
)
begin 
	#Declaracion de variables 
    declare v_meses int default 0;  
    declare v_contr int default 1; 
    declare v_monto decimal(10,2) default 0;
    declare v_tasa_interes decimal(10,2) default 0;
    declare v_saldo decimal(10,2) default 0;
    
    set v_meses = p_meses; #Cantidad de meses = cantidad de repeticiones
    set v_monto = p_monto; #
    
    #ciclo de repeticion 
    WHILE v_contr <= v_meses DO  
        set v_saldo = v_saldo + v_monto;       
        
         #crear registro
        insert into transacciones ( Mes, Monto,	Saldo)
        values(v_contr, v_monto, v_saldo);
        
        #variable de control
        set v_contr = v_contr + 1; 
    END WHILE; 
     
end;


call sp_simulador_ahorro( 350, 12 , 0); 
 
select  * from transacciones; 

delete from transacciones;
