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

```shell
/home/SEU_USUARIO/Documents/Repos/Automatic_scripts/oracle_database/oracle-EE/21.3.0/
```

### 2.2. Entre na pasta do projeto

```bash
cd ~/Documents/Repos/Automatic_scripts/oracle_database/oracle-EE
```

---

## 3. Defina a senha como variável de ambiente e Arquivo de instalação

- Escolha uma senha forte para o banco e exporte como variável de ambiente:

```bash
export ORACLE_PWD=MinhaSenhaForte123
```

- No arquivo `01_install_schemas.sql`, ajuste a senha dos usuários SYS e SYSTEM para a senha escolhida:

```sql
DEFINE SYSTEM_password = SuaSenhaAqui -- Altere "SuaSenhaAqui" para a mesma senha do SYS passada no container
DEFINE SYS_password    = SuaSenhaAqui -- Altere "SuaSenhaAqui" para a mesma senha do SYSTEM passada no container
```

---

## 4. Execute o script de instalação do banco

Use `sudo -E` para garantir que a variável de ambiente será passada para o script:

```bash
sudo -E ./01_setup_oracle21c.sh
```

Esse script irá:

- Buildar a imagem Docker do Oracle 21c EE
- Criar os diretórios necessários no seu `$HOME`
- Ajustar permissões para o usuário do Oracle no container
- Inicializar o container com os volumes e variáveis corretas
- Instalar os sample-schemas automaticamente via script SQL
- Deixar o banco pronto para uso através da porta 1521

---

## 5. Verifique a instalação

- Para acompanhar os logs do container:

```bash
docker logs -f oracle21c
```

---

## 6. Acessando o banco através do Dbeaver ou SQL Developer

- Use as seguintes credenciais:
- Host: `localhost`
  - Porta: `1521`
  - SID/Service Name: `ORCLPDB1`
  - Usuário: `SYSTEM` (ou `SYS` com role SYSDBA)
  - Senha SYS/SYSTEM: a senha que você definiu anteriormente na variável `ORACLE_PWD`
- Usuários dos sample-schemas:
  - HR: `hr` / senha `hr`
  - OE: `oe` / senha `oe`
  - PM: `pm` / senha `pm`
  - BI: `bi` / senha `bi`
  - SH: `sh` / senha `sh`

---

## 7. Observações finais

- Todos os diretórios são criados em `$HOME/oracle-dirs`, tornando o processo replicável para qualquer usuário.
- Sempre use `sudo -E` para preservar variáveis de ambiente.
- O script aceita a senha via variável de ambiente ou argumento.
- Os schemas são instalados conforme o padrão Oracle, facilitando testes e desenvolvimento.

---

**Pronto! Agora você tem um Oracle 21c EE rodando em Docker com os sample-schemas instalados e pronto para uso.**
