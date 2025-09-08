# Tutorial: Instalação do Oracle Database 21c EE + Sample Schemas via Docker

Este guia mostra como instalar o Oracle Database 21c Enterprise Edition em Docker e popular o banco com os sample-schemas oficiais da Oracle, de forma **replicável em qualquer computador Linux**.

---

## 1. Pré-requisitos

- **Docker** instalado e rodando ([instalação oficial](https://docs.docker.com/engine/install/))
- **Permissão sudo** para criar diretórios e ajustar permissões
- **Arquivo ZIP do Oracle Database 21c** (LINUX.X64_213000_db_home.zip) baixado do [site oficial Oracle](https://www.oracle.com/database/technologies/oracle21c-linux-downloads.html)
- Scripts e schemas já presentes na pasta `21.3.0/db-sample-schemas-21.1` (como no seu repositório)

---

## 2. Preparação do ambiente

### 2.1. Baixe o Oracle Database ZIP

Baixe o arquivo `LINUX.X64_213000_db_home.zip` do site da Oracle e coloque-o na pasta:

```
/home/SEU_USUARIO/Documents/Repos/Automatic_scripts/oracle_database/oracle-EE/21.3.0/
```

### 2.2. Entre na pasta do projeto

```bash
cd ~/Documents/Repos/Automatic_scripts/oracle_database/oracle-EE
```

---

## 3. Defina a senha como variável de ambiente

Escolha uma senha forte para o banco e exporte como variável de ambiente:

```bash
export ORACLE_PWD=MinhaSenhaForte123
```

---

## 4. Execute o script de instalação do banco

Use `sudo -E` para garantir que a variável de ambiente será passada para o script:

```bash
sudo -E ./01_setup_oracle19c.sh
```

Esse script irá:
- Buildar a imagem Docker do Oracle 21c EE
- Criar os diretórios necessários no seu `$HOME`
- Ajustar permissões para o usuário do Oracle no container
- Inicializar o container com os volumes e variáveis corretas

---

## 5. Instale os Sample Schemas

Após o banco estar rodando, execute o script de instalação dos schemas:

1. Edite o arquivo `21.3.0/init-scripts/01_install_schemas.sql` e altere a senha para o valor que você exportou em `ORACLE_PWD` (exemplo: `MinhaSenhaForte123`).

2. Execute o script dentro do container Oracle (pode ser via DBeaver, SQL*Plus, ou outro cliente):

```bash
sqlplus system/$ORACLE_PWD@localhost:1521/ORCLPDB1 @/opt/oracle/scripts/startup/01_install_schemas.sql
```

---

## 6. Verifique a instalação

- Para acompanhar os logs do container:

```bash
docker logs -f oracle21c
```

- Para acessar o banco via SQL*Plus:

```bash
sqlplus sys/$ORACLE_PWD@localhost:1521/ORCLCDB as sysdba
```

---

## 7. Observações finais

- Todos os diretórios são criados em `$HOME/oracle-dirs`, tornando o processo replicável para qualquer usuário.
- Sempre use `sudo -E` para preservar variáveis de ambiente.
- O script aceita a senha via variável de ambiente ou argumento.
- Os schemas são instalados conforme o padrão Oracle, facilitando testes e desenvolvimento.

---

**Pronto! Agora você tem um Oracle 21c EE rodando em Docker com os sample-schemas instalados e pronto para uso.**