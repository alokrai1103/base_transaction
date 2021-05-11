UPDATE
    cef_prod.source_stg_base_transaction B INNER JOIN
    (
        SELECT
              B.TRANSACTION_ID
            , M.MEMBERSHIP_ID
            , M.RENEWAL_OPPORTUNITY_ID
            
            , M.MEMBER_NAME_ID
        FROM  cef_prod.source_stg_base_transaction B
        INNER JOIN
            Netsuite.TRANSACTIONS t_ful 
            ON t_ful.TRANSACTION_TYPE = 'Item Fulfillment'
                AND t_ful.CREATED_FROM_ID = B.duplicate_created_from_id 
           LEFT JOIN
            Netsuite.MEMBERSHIP M
                ON M.ORIGINAL_LINKED_TRANSACTION_ID = t_ful.TRANSACTION_ID LEFT JOIN
            cef_prod.source_ns_partner_public_category  partner_public_category
                ON B.partner_public_category_id=partner_public_category.partner_public_category_id
        WHERE
           
            (partner_public_category.partner_public_category_name LIKE '%amex%'
            OR partner_public_category.partner_public_category_name LIKE '%american%')
            
           AND B.duplicate_created_from_id is not null
                AND B.partner_public_category_id IS NOT NULL
            
    ) A
        ON A.TRANSACTION_ID = B.transaction_id
SET
      membership_id = A.MEMBERSHIP_ID
    , renewal_opportunity_id = A.RENEWAL_OPPORTUNITY_ID
    , actual_customer_id = A.MEMBER_NAME_ID    

