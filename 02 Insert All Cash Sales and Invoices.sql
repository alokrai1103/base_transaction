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
    , transaction_line_id
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
    , coupon_cash_sale_id
	, sale_type
    , transaction_department 
    , sale_channel 
    , if_complimentary 
    , product 
	, net_amount
	, transaction_amount
	, payment_method
	, item_price_name 
    , item_unit_price 
    , currency_id
    , currency_symbol 
	, sales_rep_id
    , employee_name

)
SELECT 
      T1.ENTITY_ID AS CustomerId
    , T1.TRANSACTION_ID 
    , T1.TRANDATE AS transaction_date
    , T1.TRANSACTION_TYPE
    , T1.TRANID AS transaction_number
    , T1.STATUS AS transaction_status
    , T1.DUPLICATE_CREATED_FROM_ID
    , T1.CREATED_FROM_ID AS sale_order_id
	, TL.TRANSACTION_LINE_ID
    , CASE IT.MEMBERSHIP_ID 
        WHEN 1 THEN 'Primary'
        WHEN 2 THEN 'Supplementary'
        END AS MembershipItemType
    , T1.BUSINESS_CATEGORY_ID
    , T1.BUSINESS_CATEGORY_PRICE_LEV_ID
    , T1.PARTNER_PUBLIC_CATEGORY_ID
    , B.DIGITAL_CARD
    , T1.SALES_TYPE_ID
    , T1.POST_PAY
    , T1.POST_PAY_PARTNER_INVOICE_ID
    , T1.PROMOTION_CODE_ID
    , T1.PROMOTION_CODE_INSTANCE_ID
    , T1.WEB_ORDER 
    , T1.DUPLICATE_PROCESSED  
	, TL_C.COUPON_CASH_SALE_ID
	, CASE IT.ITEM_TYPE_ID
                    WHEN 1 THEN 'New Sale'
                    WHEN 2 THEN 'Renewal'
                    WHEN 3 THEN 'Late Renewal'
                    WHEN 4 THEN 'Non Renewal' END AS sale_type
    , D.name AS transaction_department 
    , C.NAME AS sale_channel 
    , IT.COMPLEMENTARY_TYPE_ID AS if_complimentary 
    , IT.NAME AS product 
	, CASE WHEN IFNULL(TL_C.AMOUNT,0) = 0 THEN CASE WHEN TL.AMOUNT < 0 THEN -TL.AMOUNT ELSE TL.AMOUNT END ELSE TL_C.AMOUNT END AS net_amount
	, CASE WHEN IFNULL(TL_C.AMOUNT,0) = 0 THEN TL_A.AMOUNT ELSE TL_C.AMOUNT END AS transaction_amount
	, PM.NAME AS payment_method
	, IP.NAME AS item_price_name 
    , IP.ITEM_UNIT_PRICE AS item_unit_price 
    , CU.CURRENCY_ID AS currency_id
    , CU.SYMBOL AS currency_symbol 
	, T1.sales_rep_id
    , E.FULL_NAME AS employee_name
FROM
   TRANSACTIONS T1 
        INNER JOIN
   TRANSACTION_LINES TL 
        ON TL.TRANSACTION_ID = T1.TRANSACTION_ID 
        INNER JOIN
   TRANSACTION_LINES TL_A 
        ON TL_A.TRANSACTION_ID = T1.TRANSACTION_ID 
        AND TL_A.TRANSACTION_ORDER = 0 
        LEFT JOIN
   ITEMS IT 
        ON TL.ITEM_ID = IT.item_id 
        LEFT JOIN 
   ITEM_PRICES IP 
        ON IP.ITEM_ID = TL.ITEM_ID 
        AND IP.CURRENCY_ID = T1.CURRENCY_ID
        AND TL.price_type_id = IP.ITEM_PRICE_ID 
        LEFT JOIN
    CURRENCIES CU
        ON CU.CURRENCY_ID = IP.CURRENCY_ID 
        LEFT JOIN
   TRANSACTION_LINES TL_C 
        ON TL_C.COUPON_CASH_SALE_ID IS NOT NULL 
        AND TL_C.COUPON_CASH_SALE_ID = T1.TRANSACTION_ID 
        AND TL_C.TRANSACTION_ORDER = 0 
        LEFT JOIN
   BUSINESS_CATEGORY B 
        ON B.BUSINESS_CATEGORY_ID=T1.BUSINESS_CATEGORY_ID 
        LEFT JOIN
   DEPARTMENTS D 
        ON D.DEPARTMENT_ID = TL.DEPARTMENT_ID 
        LEFT JOIN
   CLASSES C 
        ON C.CLASS_ID = TL.class_Id 
        LEFT JOIN
   PAYMENT_METHODS PM 
        ON PM.PAYMENT_METHOD_ID = TL_A.PAYMENT_METHOD_ID 
        LEFT JOIN
   EMPLOYEES E
        ON T1.SALES_REP_ID = E.EMPLOYEE_ID
WHERE
    T1.TRANSACTION_TYPE IN ('Cash Sale', 'Invoice')
    AND IT.ITEM_TYPE_ID IN (1, 2, 3, 4)
	AND T1.TRANDATE >=  DATE_ADD((SELECT transaction_date FROM base_transaction ORDER BY 1 DESC LIMIT 1), INTERVAL -30 DAY )

