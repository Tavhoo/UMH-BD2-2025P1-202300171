#Activar la base de datos
Use proyecto;

#Eliminar tablas
drop table cuentas;
drop table transacciones;

#Crear tabla cuentas
create table cuentas (
	num_cuenta INT primary key,
    total_creditos decimal (10, 2),
    total_debitos decimal (10, 2),
    saldo decimal (10, 2)
    ); 

#Insertar datos en la tabla cuentas
insert into cuentas (num_cuenta, total_creditos, total_debitos, saldo)
values	
	(20010001, 800, 0, 800),
    (20010002, 560, 0, 560),
    (20010003, 1254, 0, 1254),
    (20010004, 15000, 0, 15000),
    (20010005, 256, 0, 256);

#crear tabla transacciones
create table transacciones (
	id_transaccion int auto_increment primary key,
	num_cuenta INT,
    fecha date,
    credito decimal (10, 2),
    debito decimal (10, 2)
    ); 

#Insertar datos en la tabla transacciones
insert into transacciones (num_cuenta, fecha, credito, debito)
values
	(20010001, "2024/12/12", 800, 0),
    (20010002, "2025/01/5", 560, 0),
    (20010003, "2024/10/30", 1254, 0),
    (20010004, "2025/01/14", 15000, 0),
    (20010005, "2024/11/23", 256, 0);

#Creacion del procedimiento

delimiter //
drop procedure sp_new_transaccion;

delimiter //
create procedure sp_new_transaccion(
	in p_numcuenta int,
    in p_deposito decimal(10, 2),
    in p_retiro decimal(10, 2)
)
begin
	#declarar variables
    declare v_numcuenta int;
    declare v_deposito decimal(10, 2);
    declare v_fecha date default current_date;
    declare v_retiro decimal(10, 2);
    declare v_cuentaExiste int;
    
	set v_numcuenta = p_numcuenta;
    set v_deposito = p_deposito;
    set v_retiro = p_retiro;

    #consulta para verificar si la cuenta existe
    select count(*) into v_cuentaExiste from cuentas 
		where num_cuenta = p_numcuenta;

    #condicion por si no existe un numero de cuenta en la tabla de cuentas
    if v_cuentaExiste = 0 then
        select "El número de cuenta no existe" as Resultado;

	#Condicion de deposito
    elseif  p_deposito > 0 and p_retiro=0 and v_cuentaExiste = 1 then
    
    #crear registro en la tabla transacciones
		insert into transacciones (num_cuenta, fecha, credito, debito)
			values (v_numcuenta, v_fecha, v_deposito, v_retiro);
            
         #actualizar la tabla cuentas para deposito  
		update cuentas set total_creditos = total_creditos + v_deposito
			where num_cuenta= v_numcuenta;
		update cuentas set saldo = saldo + v_deposito
			where num_cuenta= v_numcuenta;
            
		#condicion de retiro
	elseif	p_retiro > 0 and p_deposito=0 and v_cuentaExiste then
    
		insert into transacciones (num_cuenta, fecha, credito, debito)
			values (v_numcuenta, v_fecha, v_deposito, v_retiro);
        
        #actualizar tabla cuentas para el retiro
		update cuentas set total_debitos = total_debitos + p_retiro
			where num_cuenta= v_numcuenta;
		update cuentas set saldo = saldo - p_retiro
			where num_cuenta= v_numcuenta;
	
    #Condición por si se esta tratando de hacer un retiro y un deposito a la vez
    elseif p_retiro > 0 and p_deposito > 0 and v_cuentaExiste then
		select "Esta tratando de realizar dos procesos a la vez" as Resultado;
	
    #condicion por si no se esta haciendo ningun deposito o retiro
    elseif p_retiro = 0 and p_deposito = 0 and v_cuentaExiste then
		select "No esta realizando ningun proceso" as Resultado;
            
	else select "No se puede realizar el proceso" as Resultado;
		 
	end if;
end;

#Llamar al procedimiento
call sp_new_transaccion(20010004, 0, 15000 );

select * from cuentas;
select * from transacciones;
