ALTER SESSION SET CONTAINER = ORCLPDB1;

-- Instalar o schema HR usando parâmetros fixos
CONNECT sys/EduLindo123@ORCLPDB1 AS SYSDBA;
@/opt/oracle/sample-schemas/human_resources/hr_main.sql hr hr hr_temp EduLindo123 /opt/oracle/sample-schemas/log/ "localhost:1521/ORCLPDB1"

COMMIT;

CONNECT sys/EduLindo123@ORCLPDB1 AS SYSDBA;
@/opt/oracle/sample-schemas/order_entry/oe_main.sql oe oe oe_temp hr EduLindo123 /opt/oracle/sample-schemas/order_entry/ /opt/oracle/sample-schemas/log/ v3 "localhost:1521/ORCLPDB1"

COMMIT;

CONNECT sys/EduLindo123@ORCLPDB1 AS SYSDBA;
@/opt/oracle/sample-schemas/product_media/pm_main.sql pm pm pm_temp oe EduLindo123 /opt/oracle/sample-schemas/product_media/ /opt/oracle/sample-schemas/log/ /opt/oracle/sample-schemas/product_media/ "localhost:1521/ORCLPDB1"

COMMIT;

CONNECT sys/EduLindo123@ORCLPDB1 AS SYSDBA;
@/opt/oracle/sample-schemas/info_exchange/ix_main.sql ix ix ix_temp EduLindo123 /opt/oracle/sample-schemas/log/ v3 "localhost:1521/ORCLPDB1"

COMMIT;

CONNECT sys/EduLindo123@ORCLPDB1 AS SYSDBA;
@/opt/oracle/sample-schemas/sales_history/sh_main.sql sh sh sh_temp EduLindo123 /opt/oracle/sample-schemas/sales_history/ /opt/oracle/sample-schemas/log/ v3 "localhost:1521/ORCLPDB1" 

COMMIT;

CONNECT sys/EduLindo123@ORCLPDB1 AS SYSDBA;
@/opt/oracle/sample-schemas/bus_intelligence/bi_main.sql bi bi bi_temp EduLindo123 oe sh /opt/oracle/sample-schemas/log/ v3 "localhost:1521/ORCLPDB1"

COMMIT;