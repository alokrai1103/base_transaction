-- DROP VIEW dave_control.vw_script_status_vv

CREATE VIEW dave_control.vw_script_status_vv
AS
SELECT
      script.script_order
    , aud.script_audit_uid
    , script.script_name
    , CONCAT(script.target_database_name, '.', script.target_table_name) AS target_db_table
    , aud.script_audit_datetime
    , aud.script_audit_count
    , aud.script_audit_status
    , aud.script_audit_output
    , script.script_uid
    , aud.instance_uid
FROM
    dave_control.script_audit aud LEFT JOIN
    dave_control.vw_script_current script
        ON aud.script_uid = script.script_uid
ORDER BY
    script_audit_uid DESC
LIMIT 500
