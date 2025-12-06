CREATE OR REPLACE PACKAGE BODY pkg_error_log IS

  PROCEDURE error_log(p_error_message VARCHAR2
                     ,p_error_value   VARCHAR2
                     ,p_api           VARCHAR2) IS
  
  BEGIN
    INSERT INTO error_log
      (err_id
      ,err_time
      ,err_message
      ,err_value
      ,api)
    VALUES
      (seq_error_log.nextval
      ,SYSDATE
      ,p_error_message
      ,p_error_value
      ,p_api);
      
  commit;
  END error_log;

END pkg_error_log;
