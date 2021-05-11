/*
DROP TABLE IF EXISTS  cef_prod.source_stg_base_transaction
GO
*/

CREATE TABLE cef_prod.source_stg_base_transaction  ( 
	customer_id              	        bigint(20) NULL
	, transaction_id           	        bigint(20) NULL
	, transaction_date         	        datetime NULL
	, transaction_type         	        varchar(255) NULL
	, transaction_number       	        varchar(255) NULL
	, transaction_status       	        varchar(255) NULL
	, duplicate_created_from_id	        varchar(255) NULL
	, sale_order_id            	        bigint(20) NULL
	, refund_id                	        bigint(20) NULL
	, refund_date              	        datetime NULL
	, fulfill_id               	        bigint(20) NULL
	, membership_item_type     	        varchar(21) NULL
	, actual_customer_id       	        bigint(20) NULL
	, renewal_opportunity_id   	        bigint(20) NULL
	, membership_id            	        bigint(20) NULL
	, sale_type                	        varchar(100) NULL
	, transaction_department   	        varchar(255) NULL
	, sale_channel             	        varchar(100) NULL
	, if_complimentary         	        varchar(25) NULL
	, subsidiary               	        varchar(25) NULL
	, customer_department      	        varchar(25) NULL
	, lead_type                	        varchar(100) NULL
	, customer_parentId        	        bigint(20) NULL
	, pmid                     	        varchar(25) NULL
	, membership_lifecycle     	        int(11) NULL
	, membership_tier          	        varchar(255) NULL
	, membership_parentId      	        bigint(20) NULL
	, membership_department    	        varchar(255) NULL
	, no_foc_rolledover        	        int(11) NULL
	, no_foc_sale              	        int(11) NULL
	, transaction_amount       	        decimal(10,0) NULL
	, item_price_name          	        varchar(255) NULL
	, item_unit_price          	        decimal(10,0) NULL
	, currency_id              	        int(11) NULL
	, currency_symbol          	        varchar(10) NULL
	, finance_year             	        int(11) NULL
	, finance_month            	        int(11) NULL
	, finance_week_no          	        int(11) NULL
	, finance_year_week_no     	        int(11) NULL
	, parent_is_person         	        varchar(10) NULL
	, pre_membership_id        	        bigint(20) NULL
	, inbound                  	        smallint(6) NULL
	, dave_campaign            	        smallint(6) NULL
	, sales_rep_id             	        int(11) NULL
	, employee_name            	        varchar(255) NULL 
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
    , subsidiary_entity                 VARCHAR(255) NULL
    , payment_method                    VARCHAR(255) NULL
    , product                           VARCHAR(255) NULL 

    , KEY (`transaction_id`) USING CLUSTERED COLUMNSTORE
    , SHARD KEY (`transaction_id`)
	)
GO
