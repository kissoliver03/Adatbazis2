CREATE OR REPLACE PACKAGE pkg_error_log IS

  PROCEDURE error_log(p_error_message VARCHAR2
                     ,p_error_value   VARCHAR2
                     ,p_api           VARCHAR2);

END pkg_error_log;
