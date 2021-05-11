/*
DROP TABLE IF EXISTS cef_prod.source_base_transaction_item
GO
*/

CREATE TABLE cef_prod.source_base_transaction_item
( 
    transaction_id        BIGINT(20) NULL
  , membership_id         BIGINT(20) NULL
  , membership_item_type  VARCHAR(100) NULL
  , is_parent             SMALLINT(6) NULL
  , item_id               BIGINT(20) NULL
  , item_name             VARCHAR(255) NULL
  , item_memo             VARCHAR(255) NULL
  , type_name             VARCHAR(100) NULL
  , KEY(`transaction_id`) USING CLUSTERED COLUMNSTORE
  , SHARD KEY(`transaction_id`)
)
GO

