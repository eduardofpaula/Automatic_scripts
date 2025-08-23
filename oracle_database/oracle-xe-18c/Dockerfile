FROM gvenzl/oracle-xe:18

USER root
RUN microdnf install perl

# Copia scripts de inicialização
COPY init-scripts/ /container-entrypoint-initdb.d/
COPY sample-schemas/ /opt/oracle/sample-schemas/

RUN chown -R oracle /opt/oracle/sample-schemas

# Define variáveis de ambiente
ENV ORACLE_PDB=XEPDB1

USER oracle