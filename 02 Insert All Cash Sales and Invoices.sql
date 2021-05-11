INSERT INTO cef_prod.source_stg_base_transaction
(
      customer_id
    , transaction_id
    , transaction_date
    , transaction_type
    , transaction_number
    , transaction_status
    , duplicate_created_from_id
    , sale_order_id
    , membership_item_type
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
    , duplicate_processed        
)
SELECT DISTINCT
      T1.ENTITY_ID AS CustomerId
    , T1.TRANSACTION_ID 
    , T1.TRANDATE 
    , T1.TRANSACTION_TYPE
    , T1.TRANID
    , T1.STATUS
    , T1.DUPLICATE_CREATED_FROM_ID
    , T1.CREATED_FROM_ID AS SaleOrderId
    , CASE IT.MEMBERSHIP_ID 
        WHEN 1 THEN 'Primary'
        WHEN 2 THEN 'Supplementary'
        END AS MembershipItemType
    , T1.BUSINESS_CATEGORY_ID
    , BUSINESS_CATEGORY_PRICE_LEV_ID
    , T1.PARTNER_PUBLIC_CATEGORY_ID
    , B.DIGITAL_CARD
    , T1.SALES_TYPE_ID
    , POST_PAY
    , POST_PAY_PARTNER_INVOICE_ID
    , PROMOTION_CODE_ID
    , PROMOTION_CODE_INSTANCE_ID
    , WEB_ORDER 
    , DUPLICATE_PROCESSED   
FROM
    Netsuite.TRANSACTIONS T1 LEFT JOIN
    Netsuite.TRANSACTION_LINES TL ON TL.TRANSACTION_ID = T1.TRANSACTION_ID LEFT JOIN
    Netsuite.ITEMS IT ON TL.ITEM_ID = IT.item_id LEFT JOIN
    Netsuite.BUSINESS_CATEGORY B ON B.BUSINESS_CATEGORY_ID=T1.BUSINESS_CATEGORY_ID
WHERE
    T1.TRANSACTION_TYPE IN ('Cash Sale', 'Invoice')
    AND IT.ITEM_TYPE_ID IN (1, 2, 3, 4)


