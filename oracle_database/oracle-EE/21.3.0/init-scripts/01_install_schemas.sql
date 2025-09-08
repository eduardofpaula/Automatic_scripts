ALTER SESSION SET CONTAINER = ORCLPDB1;

-- Defina as variáveis
DEFINE SYSTEM_password = SuaSenhaAqui -- Altere "SuaSenhaAqui" para a mesma senha do SYS passada no container
DEFINE SYS_password    = SuaSenhaAqui -- Altere "SuaSenhaAqui" para a mesma senha do SYSTEM passada no container
DEFINE HR_password     = hr
DEFINE OE_password     = oe
DEFINE PM_password     = pm
DEFINE IX_password     = ix
DEFINE SH_password     = sh
DEFINE BI_password     = bi
DEFINE default_ts      = USERS
DEFINE temp_ts         = TEMP
DEFINE log_dir         = /opt/oracle/sample-schemas/log/
DEFINE connect_string  = localhost:1521/ORCLPDB1

-- Conecta e cria diretórios
CONNECT system/&SYSTEM_password@&connect_string

-- Executa o mksample
@/opt/oracle/sample-schemas/mksample.sql &SYSTEM_password &SYS_password &HR_password &OE_password &PM_password &IX_password &SH_password &BI_password &default_ts &temp_ts &log_dir &connect_string