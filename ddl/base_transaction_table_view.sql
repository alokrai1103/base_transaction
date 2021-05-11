/*
DROP VIEW IF EXISTS cef_prod.source_vw_base_transaction
GO
DROP VIEW IF EXISTS cef_prod.source_vw_base_transaction_current
GO
DROP TABLE IF EXISTS cef_prod.source_base_transaction
GO
*/

CREATE TABLE cef_prod.source_base_transaction 
( 
    base_transaction_uid              VARCHAR(40) NOT NULL
        
  , hash_diff_base_transaction        VARCHAR(40) NOT NULL
  , load_datetime                     DATETIME not  NULL
  , active_flag                       tinyint(4) NOT NULL
  , instance_uid                      VARCHAR(40) NULL 
          
  , customer_id                       BIGINT(20) NULL
  , transaction_id                    BIGINT(20) NULL
  , transaction_date                  DATETIME NULL
  , transaction_type                  VARCHAR(255) NULL
  , transaction_number                VARCHAR(255) NULL
  , transaction_status                VARCHAR(255) NULL
  , duplicate_created_from_id         VARCHAR(255) NULL
  , sale_order_id                     BIGINT(20) NULL
  , refund_id                         BIGINT(20) NULL
  , refund_date                       DATETIME NULL
  , fulfill_id                        BIGINT(20) NULL
  , membership_item_type              VARCHAR(21) NULL
  , actual_customer_id                BIGINT(20) NULL
  , renewal_opportunity_id            BIGINT(20) NULL
  , membership_id                     BIGINT(20) NULL
  , sale_type                         VARCHAR(100) NULL
  , transaction_department            VARCHAR(255) NULL
  , sale_channel                      VARCHAR(100) NULL
  , if_complimentary                  VARCHAR(25) NULL
  , subsidiary                        VARCHAR(25) NULL
  , customer_department               VARCHAR(25) NULL
  , lead_type                         VARCHAR(100) NULL
  , customer_parentId                 BIGINT(20) NULL
  , pmid                              VARCHAR(25) NULL
  , membership_lifecycle              INT(11) NULL
  , membership_tier                   VARCHAR(255) NULL
  , membership_parentId               BIGINT(20) NULL
  , membership_department             VARCHAR(255) NULL
  , no_foc_rolledover                 INT(11) NULL
  , no_foc_sale                       INT(11) NULL
  , transaction_amount                DECIMAL(10,0) NULL
  , item_price_name                   VARCHAR(255) NULL
  , item_unit_price                   DECIMAL(10,0) NULL
  , currency_id                       INT(11) NULL
  , currency_symbol                   VARCHAR(10) NULL
  , finance_year                      INT(11) NULL
  , finance_month                     INT(11) NULL
  , finance_week_no                   INT(11) NULL
  , finance_year_week_no              INT(11) NULL
  , parent_is_person                  VARCHAR(10) NULL
  , pre_membership_id                 BIGINT(20) NULL
  , inbound                           SMALLINT(6) NULL
  , dave_campaign                     SMALLINT(6) NULL
  , sales_rep_id                      INT(11) NULL
  , employee_name                     VARCHAR(255) NULL
  , business_category_id              BIGINT(20) NULL
  , business_category_price_lev_id    BIGINT(20) NULL
  , partner_public_category_id        BIGINT(20) NULL
  , digital_card                      VARCHAR(255) NULL
  , sales_type_id                     BIGINT(20) NULL
  , post_pay                          VARCHAR(255) NULL
  , post_pay_partner_invoice_id       BIGINT(20) NULL
  , promotion_code_id                 BIGINT(20) NULL
  , promotion_code_instance_id        BIGINT(20) NULL
  , web_order                         VARCHAR(255) NULL
  , duplicate_processed               VARCHAR(10) 
  , payment_method                    VARCHAR(255) NULL
  , product                           VARCHAR(255) NULL 
  , refund_net_amount                 DECIMAL(10,2) NULL
  , net_amount                        DECIMAL(10,2) NULL
  
  , KEY (`base_transaction_uid`) USING CLUSTERED COLUMNSTORE
  , SHARD KEY (`base_transaction_uid`)
  )
GO

--alter table cef_prod.source_base_transaction  add column subsidiary_entity VARCHAR(255) NULL

CREATE VIEW cef_prod.source_vw_base_transaction
AS
SELECT
    load_datetime AS from_datetime
  , COALESCE(  LEAD(load_datetime, 1)
               OVER(PARTITION BY base_transaction_uid
                    ORDER BY load_datetime)
             , CAST('2999-12-31' AS DATETIME)) AS to_datetime

  , base_transaction_uid

  , hash_diff_base_transaction
  , active_flag               
  , instance_uid              
 
  , customer_id               
  , transaction_id            
  , transaction_date          
  , transaction_type          
  , transaction_number        
  , transaction_status        
  , duplicate_created_from_id 
  , sale_order_id             
  , refund_id                 
  , refund_date               
  , fulfill_id                
  , membership_item_type      
  , actual_customer_id        
  , renewal_opportunity_id    
  , membership_id             
  , sale_type                 
  , transaction_department    
  , sale_channel              
  , if_complimentary          
  , subsidiary                
  , customer_department       
  , lead_type                 
  , customer_parentId         
  , pmid                      
  , membership_lifecycle      
  , membership_tier           
  , membership_parentId       
  , membership_department     
  , no_foc_rolledover         
  , no_foc_sale               
  , transaction_amount        
  , item_price_name           
  , item_unit_price           
  , currency_id               
  , currency_symbol           
  , finance_year              
  , finance_month             
  , finance_week_no           
  , finance_year_week_no      
  , parent_is_person          
  , pre_membership_id         
  , inbound                   
  , dave_campaign             
  , sales_rep_id              
  , employee_name
  , business_category_id             
  , business_category_price_lev_id    
  , partner_public_category_id        
  , digital_card                      
  , sales_type_id                     
  , post_pay                          
  , post_pay_partner_invoice_id       
  , promotion_code_id                 
  , promotion_code_instance_id        
  , web_order
  , subsidiary_entity
  , duplicate_processed
  , payment_method   
  , product   
  , refund_net_amount   
  , net_amount           
FROM
  cef_prod.source_base_transaction
GO

CREATE VIEW  cef_prod.source_vw_base_transaction_current
AS
WITH base_transaction_v
AS
(
  SELECT
      *
    , ROW_NUMBER() OVER(PARTITION BY base_transaction_uid
                        ORDER BY load_datetime DESC) AS rn
  FROM
    cef_prod.source_base_transaction
)
SELECT
    *
FROM
    base_transaction_v
WHERE
    rn = 1
    and active_flag = True
GO

/*
ALTER TABLE  cef_prod.source_base_transaction  ADD  refund_net_amount  DECIMAL(10,2) NULL
GO
ALTER TABLE  cef_prod.source_base_transaction  ADD net_amount  DECIMAL(10,2) NULL
 GO
ALTER TABLE  cef_prod.source_stg_base_transaction  ADD refund_net_amount  DECIMAL(10,2) NULL
GO
ALTER TABLE  cef_prod.source_stg_base_transaction  ADD net_amount  DECIMAL(10,2) NULL 

 GO
ALTER TABLE  Netsuite.base_transaction  ADD refund_net_amount  DECIMAL(10,2) NULL
GO
ALTER TABLE  Netsuite.base_transaction  ADD net_amount  DECIMAL(10,2) NULL 
 
*/