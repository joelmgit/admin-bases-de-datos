/* CREAR UN TABLESPACE */

create tablespace ADMIN_TABLESPACE;
datafile 'c:\AdminBaseDatos\tbl.dbf' size 20M
default storage (initial 1m next 1m pctincrease 0);

/* Agregar un nuevo Datafile */

alter tablespace ADMIN_TABLESPACE add datafile 'c:\AdminBaseDatos\tbl2.dbf' size 30M;

/* Cambiar el tamaño a un Datafile */

alter database datafile 'c:\AdminBaseDatos\tbl2.dbf' resize 50M;

/* Creación de usuarios */

alter session set "_ORACLE_SCRIPT"=true;  

create user admin_user identified by admin_password 
default tablespace ADMIN_TABLESPACE
temporary tablespace temp;

create user pablito identified by pablito01 
default tablespace ADMIN_TABLESPACE
temporary tablespace temp;

/* Otorgar permisos */

grant connect,resource to admin_user;
grant connect,resource to pablito;

/* Asignar quota */

alter user admin_user quota unlimited on ADMIN_TABLESPACE;
alter user pablito quota 20M on ADMIN_TABLESPACE;

select * from v$logfile;

select * from  v$controlfile;

select * from dba_data_files;

create role rol_asistente;

grant rol_asistente to pablito;

-- revoke rol_asistente from pablito