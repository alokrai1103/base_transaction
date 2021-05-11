CREATE TABLE dave_control.script_audit (
      script_audit_uid             bigint(20) auto_increment not null

    , script_uid                   varchar(40) not null
    , instance_uid                 varchar(40) not null

    , script_audit_datetime        datetime not null
    , script_audit_status          text null
    , script_audit_count           bigint(20) null
    , script_audit_output          text null   

    , key (`script_audit_uid`) using clustered columnstore
    , shard key (`script_audit_uid`)
)
GO

/*
DROP VIEW IF EXISTS dave_control.vw_script_audit
GO
DROP VIEW IF EXISTS dave_control.vw_script_audit_current
GO
DROP TABLE IF EXISTS dave_control.script_audit
GO

CREATE TABLE dave_control.script_audit (
      script_audit_uid              varchar(40) not null

    , script_uid                    varchar(40) not null

    , hash_diff_script_audit        varchar(40) not null
    , load_datetime                 datetime not null
    , active_flag                   bool not null
    , instance_uid                  varchar(40) not null

    , script_audit_datetime         datetime not null
    , script_audit_status           text null
    , script_audit_count            bigint(20) null
    , script_audit_output           text null   

    , key (`script_audit_uid`) using clustered columnstore
    , shard key (`script_audit_uid`)
)
GO

CREATE VIEW dave_control.vw_script_audit
AS
SELECT
      load_datetime as from_datetime
    , lead (load_datetime, 1) over (partition by script_audit_uid order by load_datetime) as to_datetime

    , script_audit_uid

    , script_uid

    , hash_diff_script_audit
    , load_datetime
    , active_flag
    , instance_uid

    , script_audit_datetime                
    , script_audit_status
    , script_audit_count
    , script_audit_output
FROM
    dave_control.script_audit
GO

CREATE VIEW dave_control.vw_script_audit_current
AS
WITH script_audit_v
AS
(
    select *,
    row_number() over (partition by script_audit_uid order by load_datetime desc) as rn
    from dave_control.script_audit
)
SELECT
    *
FROM
    script_audit_v
WHERE
    rn = 1
GO
*/
