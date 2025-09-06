-- Conectar ao PDB correto (ajuste conforme sua configuração)
ALTER SESSION SET CONTAINER = ORCLPDB1;

-- criando tablespace hr
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM dba_tablespaces WHERE tablespace_name = 'HR';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TABLESPACE hr DATAFILE ''/opt/oracle/oradata/ORCLCDB/hr01.dbf'' SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED';
    END IF;
END;
/

-- criando tablespace temporário hr
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM dba_tablespaces WHERE tablespace_name = 'HR_TEMP';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TEMPORARY TABLESPACE hr_temp TEMPFILE ''/opt/oracle/oradata/ORCLCDB/hr_temp01.dbf'' SIZE 50M AUTOEXTEND ON';
    END IF;
END;
/

-- criando tablespace oe
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM dba_tablespaces WHERE tablespace_name = 'OE';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TABLESPACE oe DATAFILE ''/opt/oracle/oradata/ORCLCDB/oe01.dbf'' SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED';
    END IF;
END;
/

-- criando tablespace temporário oe
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM dba_tablespaces WHERE tablespace_name = 'OE_TEMP';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TEMPORARY TABLESPACE oe_temp TEMPFILE ''/opt/oracle/oradata/ORCLCDB/oe_temp01.dbf'' SIZE 50M AUTOEXTEND ON';
    END IF;
END;
/

-- Repita o padrão para pm, ix, sh, bi...

-- criando tablespace pm
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM dba_tablespaces WHERE tablespace_name = 'PM';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TABLESPACE pm DATAFILE ''/opt/oracle/oradata/ORCLCDB/pm01.dbf'' SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED';
    END IF;
END;
/

-- criando tablespace temporário pm
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM dba_tablespaces WHERE tablespace_name = 'PM_TEMP';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TEMPORARY TABLESPACE pm_temp TEMPFILE ''/opt/oracle/oradata/ORCLCDB/pm_temp01.dbf'' SIZE 50M AUTOEXTEND ON';
    END IF;
END;
/

-- criando tablespace ix
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM dba_tablespaces WHERE tablespace_name = 'IX';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TABLESPACE ix DATAFILE ''/opt/oracle/oradata/ORCLCDB/ix01.dbf'' SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED';
    END IF;
END;
/

-- criando tablespace temporário ix
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM dba_tablespaces WHERE tablespace_name = 'IX_TEMP';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TEMPORARY TABLESPACE ix_temp TEMPFILE ''/opt/oracle/oradata/ORCLCDB/ix_temp01.dbf'' SIZE 50M AUTOEXTEND ON';
    END IF;
END;
/

-- criando tablespace sh
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM dba_tablespaces WHERE tablespace_name = 'SH';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TABLESPACE sh DATAFILE ''/opt/oracle/oradata/ORCLCDB/sh01.dbf'' SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED';
    END IF;
END;
/

-- criando tablespace temporário sh
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM dba_tablespaces WHERE tablespace_name = 'SH_TEMP';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TEMPORARY TABLESPACE sh_temp TEMPFILE ''/opt/oracle/oradata/ORCLCDB/sh_temp01.dbf'' SIZE 50M AUTOEXTEND ON';
    END IF;
END;
/

-- criando tablespace bi
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM dba_tablespaces WHERE tablespace_name = 'BI';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TABLESPACE bi DATAFILE ''/opt/oracle/oradata/ORCLCDB/bi01.dbf'' SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED';
    END IF;
END;
/

-- criando tablespace temporário bi
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM dba_tablespaces WHERE tablespace_name = 'BI_TEMP';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TEMPORARY TABLESPACE bi_temp TEMPFILE ''/opt/oracle/oradata/ORCLCDB/bi_temp01.dbf'' SIZE 50M AUTOEXTEND ON';
    END IF;
END;
/

COMMIT;

CREATE OR REPLACE DIRECTORY SS_OE_XMLDIR AS '/home/OE/PurchaseOrders';
GRANT READ, WRITE ON DIRECTORY SS_OE_XMLDIR TO OE;
GRANT EXECUTE ON DIRECTORY SS_OE_XMLDIR TO OE;

-- Também é necessário para subdiretórios
CREATE OR REPLACE DIRECTORY SUBDIR AS '/home/OE/PurchaseOrders';
GRANT READ, WRITE ON DIRECTORY SUBDIR TO OE;
GRANT EXECUTE ON DIRECTORY SUBDIR TO OE;

CREATE OR REPLACE DIRECTORY LOG_FILE_DIR AS '/opt/oracle/sample-schemas/log/';
CREATE OR REPLACE DIRECTORY DATA_FILE_DIR AS '/opt/oracle/sample-schemas/sales_history/';
GRANT READ, WRITE ON DIRECTORY LOG_FILE_DIR TO SH;
GRANT READ, WRITE ON DIRECTORY DATA_FILE_DIR TO SH;

COMMIT;