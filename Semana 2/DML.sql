CREATE TABLE empleado(
	codigo int not null,
	nombre varchar(30) not null,
	primary key(codigo)
)

insert into empleado (codigo,nombre) values (1,'juan');
 
select * from empleado;

grant select on empleado to rol_asistente;


