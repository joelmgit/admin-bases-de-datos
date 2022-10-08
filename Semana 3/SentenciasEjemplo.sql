/*1*/

create tablespace tbl_ventas
datafile 'c:\AdminBaseDatos\tbl_ventas01.dbf' size 10M
default storage (initial 1m next 1m pctincrease 0);

/* Agregar un nuevo Datafile */

alter tablespace tbl_ventas add datafile 'c:\AdminBaseDatos\tbl_ventas02.dbf' size 10M;

/* Cambiar el tamaño a un Datafile */

alter database datafile 'c:\AdminBaseDatos\tbl_ventas02.dbf' resize 20M;

/* Creación de usuarios */

alter session set "_ORACLE_SCRIPT"=true;  

create user ventas identified by ventas 
default tablespace tbl_ventas
temporary tablespace temp;

/* Otorgar permisos */

grant connect,resource to ventas;

/* Asignar quota */

alter user ventas quota unlimited on tbl_ventas;

select * from v$logfile;

select * from  v$controlfile;

select * from dba_data_files;

create role rol_consulta;

grant rol_asistente to pablito;

-- revoke rol_asistente from pablito


create user asisteventas identified by contra 
default tablespace tbl_ventas
temporary tablespace temp;

/* Otorgar permisos */

grant connect,resource to asisteventas;

/* Asignar quota */

alter user asisteventas quota unlimited on tbl_ventas;

grant select on AUTOR to rol_consulta;

grant select on LIBRO to rol_consulta;	

grant select on GENERO to rol_consulta;	

grant select on AUTOR_LIBRO to rol_consulta;	

grant select on GENERO_LIBRO to rol_consulta;