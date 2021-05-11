WITH
  order_scripts AS
  (
    SELECT
        'base_transaction' as batch_name
      , script_path
      , script_name
      , FIELD(  script_name
              , '01 Truncate Base Transaction Table.sql'
              , '02 Insert All Cash Sales and Invoices.sql'
              , '02.1 update refund.sql'
              , '02.2 update fullfillment.sql'
              , '03 update Member Membership Opportunity (excluding AMEX and Online).sql'
              , '04 update Cash Sales and Invoices detail.sql'
              , '05 update Customer (linked to the CS or INV) detail.sql'
              , '06 update AMEX and Online Member Membership Opportunity.sql'
              , '06.1 Nord update AMEX Member Membership Opportunity.sql'
              , '07 update Membership (linked to CS or INV) detail.sql'
              , '08 Update number of rollover FOC for membership.sql'
              , '09 Update number of FOC came with sale for membership.sql'
              , '10 Update CS or INV transaction amount.sql'
              , '11 Update transaction amount detail.sql'
              , '12 Update Finance Calendar information.sql'
              , '13 Update if Customer parent is person.sql'
              , '14 Try update previous membership.sql'
              , '15 Update Sales Rep for CS and INV.sql'
              , '15.1 update inbounce flag.sql'
              , '16 update Supplementary in P plus S Online sales package revenue to 0.sql'
              , '16.1 cdc base transaction.sql'
              , '16.2 truncate Netsuite base transaction.sql'
              , '16.3 Update Netsute base transaction.sql'
              , '17 Truncate Item.sql'
              , '18 Update Item.sql'
              ) AS script_order
      , target_database_name
      , target_table_name
    FROM
      dave_control.script_list
  )

  , get_batch_uid AS
  (
    SELECT
        b.batch_uid
      , a.script_path
      , a.script_name
      , a.target_database_name
      , a.target_table_name
      , a.script_order
    FROM
      order_scripts a left join
      dave_control.batch b on a.batch_name=b.batch_name
  )

  , select_hash AS
  (
    SELECT
        sha1(script_order) as script_uid
      , batch_uid

      , sha1(replace(concat(       batch_uid
                            , ',', ifnull(script_path, '')
                            , ',', ifnull(script_name, '')
                            , ',', ifnull(target_database_name, '')
                            , ',', ifnull(target_table_name, ''))
                     , ' ', '')) as hash_diff_script
       , script_path
       , script_name
       , target_database_name
       , target_table_name
       , script_order
    FROM
      get_batch_uid
  )

  , pseudo_outer_join AS
  (
    SELECT
        'stg' as col_source
      , script_uid
      , batch_uid
      , hash_diff_script
      , script_path
      , script_name
      , target_database_name
      , target_table_name
      , script_order
      
      , NOW() AS from_datetime
    FROM
      select_hash

    UNION ALL

    SELECT
        'current_view' as col_source
      , script_uid
      , batch_uid
      , hash_diff_script
    
      , script_path
      , script_name
      , target_database_name
      , target_table_name
      , script_order

      , load_datetime AS from_datetime
    FROM
      dave_control.vw_script_current
  )

  , get_lag_hash_diff AS
  (
    SELECT
        lag(hash_diff_script, 1) over (partition by script_uid order by from_datetime) as lag_hash_diff_script
      , *
      , row_number() over (partition by pseudo_outer_join.script_uid order by pseudo_outer_join.from_datetime desc) as rn
    FROM
      pseudo_outer_join
  )

  , cdc_identification AS
  (
    SELECT
        case when lag_hash_diff_script = hash_diff_script then 'NC'
           when col_source='stg' and lag_hash_diff_script != hash_diff_script then 'MOD'
           when col_source='stg' and lag_hash_diff_script is null then 'INS'
           when col_source='current_view' and lag_hash_diff_script is null then 'DEL'
         end as cdc_identification
      , *
    FROM
      get_lag_hash_diff
    WHERE
      rn = 1
  )

INSERT INTO dave_control.script
(
    script_uid

  , batch_uid

  , hash_diff_script
  , load_datetime
  , active_flag
  , instance_uid

  , script_path
  , script_name
  , target_database_name
  , target_table_name
  , script_order
)
SELECT
    script_uid

  , batch_uid

  , hash_diff_script
  , NOW() AS load_datetime
  , CASE
      WHEN cdc_identification = 'DEL' THEN False
      ELSE True
      END AS active_flag
  , 'instance-0000-0000-0000-000000000000' AS instance_uid

  , script_path
  , script_name
  , target_database_name
  , target_table_name
  , script_order
FROM 
  cdc_identification
WHERE
  cdc_identification IN ('MOD', 'INS', 'DEL')
GO
