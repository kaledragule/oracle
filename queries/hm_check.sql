/* Oracle Health Monitor Run and Report
-- Created By: BSD 20161007
*/
SET SERVEROUTPUT ON;
SET LONG 100000
SET LONGCHUNKSIZE 1000
SET PAGESIZE 1000
SET LINESIZE 512

DECLARE
  TYPE        hm_records      IS TABLE OF VARCHAR(50);
  v_array     hm_records;
BEGIN
  BEGIN
    SELECT NAME BULK COLLECT INTO v_array FROM V$HM_CHECK;
    FOR i IN v_array.First .. v_array.Last
    LOOP
      DBMS_OUTPUT.PUT_LINE(i || ':  ' || v_array(i));
    END LOOP;
  END;
  /

  VARIABLE check CHAR
  ACCEPT selection PROMPT 'CHOOSE HEALTH MONITOR CHECK: '
  EXEC :check := &selection;

  DECLARE
    sql_stmt    VARCHAR2(100)   := 'SELECT DBMS_HM.GET_RUN_REPORT(:check) FROM DUAL';
    rec         VARCHAR2(50)    := :check || '_Check_' || TO_CHAR(SYSDATE, 'MMDDYYYY_HH24MI');
    output      VARCHAR2(32767);
  BEGIN
    DBMS_OUTPUT.PUT_LINE(rec);
    CASE :check
      WHEN '1'  THEN   DBMS_HM.RUN_CHECK('HM Test Check', rec);
      WHEN '24' THEN   DBMS_HM.RUN_CHECK('Dictionary Integrity Check', rec);
      ELSE             DBMS_OUTPUT.PUT_LINE('INVALID SELECTION!!');
    END CASE;
    EXECUTE IMMEDIATE sql_stmt INTO output USING rec;
    DBMS_OUTPUT.PUT_LINE(output);
  END;
  /
END:
/
