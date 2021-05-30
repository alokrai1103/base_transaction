/*
UPDATE
    cef_prod.source_stg_base_transaction B INNER JOIN
    (
        SELECT
              B.TRANSACTION_ID
            , M.MEMBERSHIP_ID
            , M.RENEWAL_OPPORTUNITY_ID
            , CASE it.MEMBERSHIP_ID
                WHEN 1 THEN 'Primary'
                WHEN 2 THEN 'Supplementary'
                END AS MembershipItemType
            , M.MEMBER_NAME_ID
        FROM
            Netsuite.TRANSACTIONS t_ful INNER JOIN
            Netsuite.TRANSACTIONS T
                ON t_ful.CREATED_FROM_ID = T.TRANSACTION_ID INNER JOIN
            Netsuite.TRANSACTION_LINES tl
                ON tl.TRANSACTION_ID = T.TRANSACTION_ID LEFT JOIN
            Netsuite.ITEMS it
                ON tl.ITEM_ID = it.item_id LEFT JOIN
            cef_prod.source_stg_base_transaction B
                ON T.duplicate_created_from_id = B.transaction_id
                AND CASE it.MEMBERSHIP_ID 
                    WHEN 1 THEN 'Primary' 
                    WHEN 2 then 'Supplementary'
                    END = B.membership_item_type LEFT JOIN
            Netsuite.MEMBERSHIP M
                ON M.ORIGINAL_LINKED_TRANSACTION_ID = t_ful.TRANSACTION_ID LEFT JOIN
            cef_prod.source_ns_partner_public_category  partner_public_category
                ON B.partner_public_category_id=partner_public_category.partner_public_category_id
        WHERE
           ( (B.sale_channel LIKE '%Amex%' OR B.sale_channel = 'Online') or partner_public_category.partner_public_category_name LIKE '%Amex%' )
            AND T.TRANSACTION_TYPE = 'Sales Order'
            AND t_ful.TRANSACTION_TYPE = 'Item Fulfillment'
    ) A
        ON A.TRANSACTION_ID = B.transaction_id
            AND A.MembershipItemType = B.membership_item_type
SET
      membership_id = A.MEMBERSHIP_ID
    , renewal_opportunity_id = A.RENEWAL_OPPORTUNITY_ID
    , actual_customer_id = A.MEMBER_NAME_ID    

*/
