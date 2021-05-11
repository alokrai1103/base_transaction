/*
DROP VIEW IF EXISTS dave_control.vw_script
GO
DROP VIEW IF EXISTS dave_control.vw_script_current
GO
DROP TABLE IF EXISTS dave_control.script
GO
*/

CREATE TABLE dave_control.script (
      script_uid                varchar(40) not null

    , batch_uid                 varchar(40) not null
    
    , hash_diff_script          varchar(40) not null
    , load_datetime             datetime not null
    , active_flag               bool not null
    , instance_uid              varchar(40) not null

    , script_path               varchar(300) not null
    , script_name               varchar(200) not null
    , target_database_name      varchar(100) not null
    , target_table_name         varchar(100) not null
    , script_order              bigint(20) not null

    , key (`script_uid`) using clustered columnstore
    , shard key (`script_uid`)
)
GO

CREATE VIEW dave_control.vw_script
AS
SELECT
      load_datetime as from_datetime
    , coalesce(  lead(load_datetime, 1)
                     over (partition by script_uid order by load_datetime)
               , cast('2999-12-31' as datetime)) as to_datetime

    , script_uid
    , batch_uid

    , hash_diff_script
    , active_flag
    , instance_uid

    , script_path                
    , script_name
    , target_database_name
    , target_table_name
    , script_order
FROM
    dave_control.script
GO

CREATE VIEW dave_control.vw_script_current
AS
WITH script_v
AS
(
    select *,
    row_number() over (partition by script_uid order by load_datetime desc) as rn
    from dave_control.script
)
SELECT
    *
FROM
    script_v
WHERE
    rn = 1
    and active_flag = True
    -- and script_order>0
GO
