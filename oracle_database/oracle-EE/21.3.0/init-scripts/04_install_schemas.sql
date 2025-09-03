ALTER SESSION SET CONTAINER = ORCLPDB1;

-- Instalar o schema HR usando parâmetros fixos
@/opt/oracle/sample-schemas/human_resources/hr_main.sql hr hr hr_temp 'oracle' /tmp/ "localhost:1521/ORCLPDB1"

COMMIT;