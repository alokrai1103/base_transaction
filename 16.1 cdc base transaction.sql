WITH
    base_transaction_outer_join AS
    (
        SELECT
              'stg' as col_source
            , SHA1(REPLACE(CONCAT(       transaction_id
                                  , ',', IFNULL(membership_item_type, ''))
                           , ' ', '')) AS base_transaction_uid
            , SHA1(REPLACE(CONCAT(       IFNULL(customer_id, '')
                                  , ',', IFNULL(transaction_id, '')
                                  , ',', IFNULL(transaction_date, '') 
                                  , ',', IFNULL(transaction_type, '')
                                  , ',', IFNULL(transaction_number, '')
                                  , ',', IFNULL(transaction_status, '')
                                  , ',', IFNULL(duplicate_created_from_id, '')
                                  , ',', IFNULL(sale_order_id, '')
                                  , ',', IFNULL(refund_id, '')
                                  , ',', IFNULL(refund_date, '')
                                  , ',', IFNULL(fulfill_id, '')
                                  , ',', IFNULL(membership_item_type, '')
                                  , ',', IFNULL(actual_customer_id, '')
                                  , ',', IFNULL(renewal_opportunity_id, '')
                                  , ',', IFNULL(membership_id, '')
                                  , ',', IFNULL(sale_type, '')
                                  , ',', IFNULL(transaction_department, '')
                                  , ',', IFNULL(sale_channel, '')
                                  , ',', IFNULL(if_complimentary, '')
                                  , ',', IFNULL(subsidiary, '')
                                  , ',', IFNULL(customer_department, '')
                                  , ',', IFNULL(lead_type, '')
                                  , ',', IFNULL(customer_parentId, '')
                                  , ',', IFNULL(pmid, '')
                                  , ',', IFNULL(membership_lifecycle, '')
                                  , ',', IFNULL(membership_tier, '')
                                  , ',', IFNULL(membership_parentId, '')
                                  , ',', IFNULL(membership_department, '')
                                  , ',', IFNULL(no_foc_rolledover, '')
                                  , ',', IFNULL(no_foc_sale, '')
                                  , ',', IFNULL(transaction_amount, '')
                                  , ',', IFNULL(item_price_name, '')
                                  , ',', IFNULL(item_unit_price, '')
                                  , ',', IFNULL(currency_id, '')
                                  , ',', IFNULL(currency_symbol, '')
                                  , ',', IFNULL(finance_year, '')
                                  , ',', IFNULL(finance_month, '')
                                  , ',', IFNULL(finance_week_no, '')
                                  , ',', IFNULL(finance_year_week_no, '')
                                  , ',', IFNULL(parent_is_person, '')
                                  , ',', IFNULL(pre_membership_id, '')
                                  , ',', IFNULL(inbound, '')
                                  , ',', IFNULL(dave_campaign, '')
                                  , ',', IFNULL(sales_rep_id, '')
                                  , ',', IFNULL(employee_name, '')
                                  , ',', IFNULL(business_category_id, '')
                                  , ',', IFNULL(business_category_price_lev_id, '')
                                  , ',', IFNULL(partner_public_category_id, '')
                                  , ',', IFNULL(digital_card, '')
                                  , ',', IFNULL(sales_type_id, '')
                                  , ',', IFNULL(post_pay, '')
                                  , ',', IFNULL(post_pay_partner_invoice_id, '')
                                  , ',', IFNULL(promotion_code_id, '')
                                  , ',', IFNULL(promotion_code_instance_id, '')
                                  , ',', IFNULL(web_order, '')
                                  , ',', IFNULL(subsidiary_entity, '')
                                  , ',', IFNULL(duplicate_processed, '')
                                  , ',', IFNULL(payment_method, '')
                                  , ',', IFNULL(product, '')
                                  , ',', IFNULL(refund_net_amount, '')
                                  , ',', IFNULL(net_amount, '')
                                  )             
                           , ' ', '')) AS hash_diff_base_transaction
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
            , NOW() as from_datetime
        FROM
             cef_prod.source_stg_base_transaction 

        UNION ALL

        SELECT
              'current_view' as col_source
            , base_transaction_uid
            , hash_diff_base_transaction
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
            , load_datetime AS from_datetime
        FROM
            cef_prod.source_vw_base_transaction_current
    ),

    get_lag_hash_diff AS
    (
        SELECT
        lag(hash_diff_base_transaction, 1) over (partition by base_transaction_uid order by from_datetime) as lag_hash_diff_base_transaction
        , *
        , row_number() over (partition by base_transaction_outer_join.base_transaction_uid order by base_transaction_outer_join.from_datetime desc) as rn
        FROM
        base_transaction_outer_join
    ),

    cdc_identification AS
    (
        SELECT
              case when lag_hash_diff_base_transaction = hash_diff_base_transaction then 'NC'
                   when col_source='stg' and lag_hash_diff_base_transaction != hash_diff_base_transaction then 'MOD'
                   when col_source='stg' and lag_hash_diff_base_transaction is null then 'INS'
                   when col_source='current_view' and lag_hash_diff_base_transaction is null then 'DEL'
                 end as cdc_identification
            , *
        FROM
            get_lag_hash_diff
        WHERE
            rn = 1
    )

INSERT INTO  cef_prod.source_base_transaction
 (
      base_transaction_uid
    
    , hash_diff_base_transaction
    , load_datetime
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
    ) 
    

SELECT
      base_transaction_uid

    , hash_diff_base_transaction
    , now() as load_datetime
    , case when cdc_identification='DEL' then False
           else True
           end as active_flag
    , 'instance-0000-0000-0000-000000000000' as instance_uid

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
    cdc_identification
WHERE
    cdc_identification in ('MOD', 'INS', 'DEL') 
GO
