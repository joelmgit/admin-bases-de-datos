create tablespace Tbl_Matricula
datafile 'c:\Caso1\datos.dbf' size 20M
default storage (initial 1m next 1m pctincrease 0);

create user administrador identified by administrador
	default tablespace Tbl_Matricula
	temporary tablespace temp;


grant connect,resource to administrador;

alter user administrador quota unlimited on Tbl_Matricula;


create user asistente identified by asistente
	default tablespace Tbl_Matricula
	temporary tablespace temp;

grant connect,resource to asistente;

alter user asistente quota 10M on Tbl_Matricula;

create user viajes identified by viajes
	default tablespace Tbl_Matricula
	temporary tablespace temp;

grant connect,resource to viajes;

alter user viajes quota unlimited on Tbl_Matricula;

create role rol_viajes;

grant role to viajes;

-- connected as viajes --

CREATE TABLE CAMION(
	PLACA INT NOT NULL, /* PK */
	MODELO INT NOT NULL,
	CAPACIDAD FLOAT NOT NULL,
	MARCA VARCHAR(20) NOT NULL,
	CONSTRAINT PK_CAMION PRIMARY KEY(PLACA)
);

CREATE TABLE CHOFER(
	ID_CHOFER INT NOT NULL,  /* PK */
	NOMBRE 	VARCHAR(30) NOT NULL,
	APELLIDO1 VARCHAR(30) NOT NULL,
	APELLIDO2 VARCHAR(30) NOT NULL,
	EDAD INT NOT NULL,
	GENERO VARCHAR(1) NOT NULL,
	ANTIGUEDAD INT NOT NULL,
	DIRECCION VARCHAR(50) NOT NULL,
	CONSTRAINT PK_CHOFER PRIMARY KEY(ID_CHOFER)
);

CREATE TABLE VIAJE(
	NUM_VIAJE INT NOT NULL,  /* PK */
	PESO FLOAT NOT NULL,
	FECHA_SALIDA DATE NOT NULL,
	FECHA_LLEGADA DATE NOT NULL,
	CODIGO_CARGA VARCHAR(10) NOT NULL,
	ID_CHOFER INT NOT NULL, /* FK */
	PLACA INT NOT NULL, /* FK */
	CONSTRAINT PK_VIAJE PRIMARY KEY(NUM_VIAJE),
	CONSTRAINT FK_VIAJE_CHOFER FOREIGN KEY (ID_CHOFER) REFERENCES CHOFER(ID_CHOFER),
	CONSTRAINT FK_VIAJE_CAMION FOREIGN KEY (PLACA) REFERENCES CAMION(PLACA)
	);


grant select,insert,delete,update on CAMION to rol_viajes;
grant select,insert,delete,update on CHOFER to rol_viajes;
grant select,insert,delete,update on VIAJE to rol_viajes;

-- connected as sys --

create role rol_administra;

grant rol_administra to administrador;

create role rol_asistencia;

grant rol_asistencia to asistente;

-- connected as viajes --

grant select,delete,insert,update on CAMION to rol_administra;
grant select,delete,insert,update on CHOFER to rol_administra;
grant select,delete,insert,update on VIAJE to rol_administra;

grant select on CAMION to rol_asistencia;
grant select on CHOFER to rol_asistencia;
grant select on VIAJE to rol_asistencia;

-- connected as asistente --

UPDATE OWNER.CAMION SET MODELO = 2 WHERE PLACA = 2;

-- connected as sys --

SELECT DISTINCT sgm.TABLESPACE_NAME, sgm.OWNER
FROM DBA_SEGMENTS sgm
JOIN DBA_DATA_FILES dtf ON (sgm.TABLESPACE_NAME = dtf.TABLESPACE_NAME)
WHERE sgm.OWNER = 'VIAJES';

SELECT USERNAME, DEFAULT_TABLESPACE FROM dba_users;


select TABLESPACE_NAME, BYTES, BLOCKS from dba_free_space WHERE TABLESPACE_NAME = 'TBL_MATRICULA';

SELECT * FROM dba_tab_privs;

select NAME from v$controlfile;
SELECT MEMBER FROM v$logfile;
SELECT NAME FROM v$datafile;


SELECT DISTINCT STATUS, SGM.TABLESPACE_NAME
FROM DBA_SEGMENTS sgm
JOIN DBA_DATA_FILES dtf ON (sgm.TABLESPACE_NAME = dtf.TABLESPACE_NAME)
WHERE sgm.OWNER = 'VIAJES';

SELECT OWNER, TABLE_NAME, TABLESPACE_NAME  FROM DBA_TABLES WHERE OWNER = 'VIAJES';


SELECT DISTINCT dtf.TABLESPACE_NAME, dtf.BLOCKS
FROM DBA_SEGMENTS sgm
JOIN DBA_DATA_FILES dtf ON (sgm.TABLESPACE_NAME = dtf.TABLESPACE_NAME)
WHERE sgm.OWNER = 'VIAJES';

SELECT TABLESPACE_NAME, SEGMENT_NAME, BYTES, EXTENTS
FROM DBA_SEGMENTS
WHERE OWNER = 'VIAJES';