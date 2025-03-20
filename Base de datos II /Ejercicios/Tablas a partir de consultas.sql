use proyecto;


#Crear tablas a partir de consultas
create table reporte_venta_mensual as 
	select year, monthnumber, segment, sum(sales) total
		from financialsample
			where year = 2013
				group by year, monthnumber, segment;


truncate table reporte;

select * from reporte_venta_mensual;

#Insertar registros a partir de una consulta
insert into reporte_venta_mensual
	select year, monthnumber, segment, sum(sales) total
		from financialsample
			where year = 2014
				group by year, monthnumber, segment;

#Subconsulta
Select segment, country from financialsample
	where product = " Carretera "
		and country not in(
			select country from currencies where exchange_rate > 1);

