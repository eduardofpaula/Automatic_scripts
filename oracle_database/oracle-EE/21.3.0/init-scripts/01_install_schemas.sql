-- filepath: /home/eduardo/Documents/Repos/Automatic_scripts/oracle_database/oracle-EE/21.3.0/init-scripts/04_install_schemas.sql
ALTER SESSION SET CONTAINER = ORCLPDB1;

-- Conectar como SYSTEM para executar o script principal da Oracle
CONNECT system/EduLindo123@localhost:1521/ORCLPDB1;

-- Executar o script oficial da Oracle conforme README.txt seção 2.4
-- @mksample <SYSTEM_password> <SYS_password> <HR_password> <OE_password> <PM_password> <IX_password> <SH_password> <BI_password> <default_tablespace> <temp_tablespace> <log_directory> <connect_string>

@/opt/oracle/sample-schemas/mksample.sql EduLindo123 EduLindo123 hr oe pm ix sh bi USERS TEMP /opt/oracle/sample-schemas/log/ localhost:1521/ORCLPDB1

COMMIT;