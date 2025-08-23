-- Testar tabelas do schema HR
BEGIN
   FOR t IN (SELECT table_name FROM all_tables WHERE owner = 'HR') LOOP
      DECLARE v_count NUMBER;
      BEGIN
         EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM HR.' || t.table_name INTO v_count;
         DBMS_OUTPUT.PUT_LINE('Tabela: ' || t.table_name || ' -> ' || v_count || ' registros.');
      END;
   END LOOP;
END;

-- Testar tabelas do schema OE
BEGIN
   FOR t IN (SELECT table_name FROM all_tables WHERE owner = 'OE') LOOP
      DECLARE v_count NUMBER;
      BEGIN
         EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM OE.' || t.table_name INTO v_count;
         DBMS_OUTPUT.PUT_LINE('Tabela: ' || t.table_name || ' -> ' || v_count || ' registros.');
      END;
   END LOOP;
END;
PROMPT Tabelas OE testadas.

-- Testar tabelas do schema SH
BEGIN
   FOR t IN (SELECT table_name FROM all_tables WHERE owner = 'SH') LOOP
      DECLARE v_count NUMBER;
      BEGIN
         EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM SH.' || t.table_name INTO v_count;
         DBMS_OUTPUT.PUT_LINE('Tabela: ' || t.table_name || ' -> ' || v_count || ' registros.');
      END;
   END LOOP;
END;