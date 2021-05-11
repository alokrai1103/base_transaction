DROP VIEW IF EXISTS dave_control.vw_batch
GO
DROP VIEW IF EXISTS dave_control.vw_batch_current
GO

DROP TABLE IF EXISTS dave_control.batch
GO


CREATE TABLE dave_control.batch (
      batch_uid             varchar(40) not null

    , hash_diff_batch       varchar(40) not null
    , load_datetime         datetime not null
    , active_flag           bool not null
    , instance_uid          varchar(40) not null

    , batch_name            varchar(100) not null
    , batch_description     varchar(100) not null
    
    , key (`batch_uid`) using clustered columnstore
    , shard key (`batch_uid`)
)
GO

CREATE VIEW dave_control.vw_batch
AS
SELECT
      load_datetime as from_datetime
    , lead (load_datetime, 1) over (partition by batch_uid order by load_datetime) as to_datetime

    , batch_uid

    , hash_diff_batch
    , active_flag
    , instance_uid

    , batch_name                
    , batch_description                  
FROM
    dave_control.batch
GO

CREATE VIEW dave_control.vw_batch_current
AS
WITH batch_v
AS
(
    select *,
    row_number() over (partition by batch_uid order by load_datetime desc) as rn
    from dave_control.batch
)
SELECT
    *
FROM
    batch_v
WHERE
    rn = 1
GO

INSERT INTO dave_control.batch
( 
    batch_uid
  , hash_diff_batch
  , load_datetime
  , active_flag
  , instance_uid
  , batch_name
  , batch_description
)
VALUES
      (  sha1(concat('base_transaction', 'populate base_transaction'))
       , sha1(concat('hash_diff', 'base_transaction', 'populate base_transaction'))
       ,now()
       , True
       , 'instance-0000-0000-0000-000000000000'
       , 'base_transaction'
       , 'populate base_transaction')
GO
