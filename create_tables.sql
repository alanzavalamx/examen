-- Creación del esquema si no existe
CREATE SCHEMA IF NOT EXISTS MemSch;


DROP TABLE IF EXISTS MemSch.MemTraTcDet CASCADE;
CREATE TABLE MemSch.MemTraTcDet (
    idTc INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    fecha DATE NOT NULL,
    valor NUMERIC(10,6),
    FechaUltimaMod TIMESTAMP,
    NombrePcMod VARCHAR(30),
    ClaUsuarioMod INT,
    CONSTRAINT fecha_unica UNIQUE (fecha)
);


DROP TABLE IF EXISTS MemSch.MemTraMDADet CASCADE;
CREATE TABLE MemSch.MemTraMDADet (
    idMDA BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY,
    claNodo VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    hora SMALLINT NOT NULL,
    pml NUMERIC(10,5),
    pml_ene NUMERIC(10,5),
    pml_per NUMERIC(10,5),
    pml_cng NUMERIC(10,5),
    FechaUltimaMod TIMESTAMP,
    NombrePcMod CHAR(30),
    ClaUsuarioMod INT,
    PRIMARY KEY (claNodo, fecha, hora) 
);


DROP TABLE IF EXISTS MemSch.MemTraMTRDet CASCADE;
CREATE TABLE MemSch.MemTraMTRDet (
    idMTR BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY,
    claNodo VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    hora SMALLINT NOT NULL,
    pml NUMERIC(10,5),
    pml_ene NUMERIC(10,5),
    pml_per NUMERIC(10,5),
    pml_cng NUMERIC(10,5),
    FechaUltimaMod TIMESTAMP,
    NombrePcMod CHAR(10),
    ClaUsuarioMod INT,
    PRIMARY KEY (claNodo, fecha, hora)
);


DROP TABLE IF EXISTS MemSch.MemTraTBFinVw CASCADE;
CREATE TABLE MemSch.MemTraTBFinVw (
    fecha DATE,
    TbFin NUMERIC(38,14),
    TbFinTGR NUMERIC(38,9)
);