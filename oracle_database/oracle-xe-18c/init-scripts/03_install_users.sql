ALTER SESSION SET CONTAINER = XEPDB1;

-- Criar tablespaces dedicados
CREATE TABLESPACE hr
  DATAFILE '/opt/oracle/oradata/XE/hr01.dbf'
  SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;

CREATE TEMPORARY TABLESPACE hr_temp
  TEMPFILE '/opt/oracle/oradata/XE/hr_temp01.dbf'
  SIZE 50M AUTOEXTEND ON;

CREATE TABLESPACE oe
  DATAFILE '/opt/oracle/oradata/XE/oe01.dbf'
  SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;

CREATE TEMPORARY TABLESPACE oe_temp
  TEMPFILE '/opt/oracle/oradata/XE/oe_temp01.dbf'
  SIZE 50M AUTOEXTEND ON;

CREATE TABLESPACE sh
  DATAFILE '/opt/oracle/oradata/XE/sh01.dbf'
  SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;

CREATE TEMPORARY TABLESPACE sh_temp
  TEMPFILE '/opt/oracle/oradata/XE/sh_temp01.dbf'
  SIZE 50M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;

-- HR
CONNECT sys/oracle@localhost:1521/XEPDB1 AS SYSDBA
@/opt/oracle/sample-schemas/human_resources/hr_main.sql hr hr hr_temp oracle /tmp/ "localhost:1521/XEPDB1"

-- OE
CONNECT sys/oracle@localhost:1521/XEPDB1 AS SYSDBA
@/opt/oracle/sample-schemas/order_entry/oe_main.sql oe oe oe_temp hr oracle /opt/oracle/sample-schemas/order_entry/ /tmp/ v3 "localhost:1521/XEPDB1"

-- SH
CONNECT sys/oracle@localhost:1521/XEPDB1 AS SYSDBA
@/opt/oracle/sample-schemas/sales_history/sh_main.sql sh sh sh_temp oracle /opt/oracle/sample-schemas/sales_history/ /tmp/ v3 "localhost:1521/XEPDB1"