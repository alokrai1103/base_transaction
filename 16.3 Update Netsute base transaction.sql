INSERT INTO 
  Netsuite.base_transaction
  (   base_transaction_uid
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
    , sale_order_id, refund_id
    , refund_date, fulfill_id
    , membership_item_type
    , actual_customer_id
    , renewal_opportunity_id
    , membership_id, sale_type
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
    , digital_card, sales_type_id
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
    , sale_order_id, refund_id
    , refund_date, fulfill_id
    , membership_item_type
    , actual_customer_id
    , renewal_opportunity_id
    , membership_id, sale_type
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
    , digital_card, sales_type_id
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
    cef_prod.source_vw_base_transaction_current   

