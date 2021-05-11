UPDATE
    cef_prod.source_stg_base_transaction B LEFT JOIN
    Netsuite.MEMBERSHIP M
        ON M.ORIGINAL_LINKED_TRANSACTION_ID = B.fulfill_id 
SET
      membership_id = M.MEMBERSHIP_ID
    , renewal_opportunity_id = M.RENEWAL_OPPORTUNITY_ID
    , actual_customer_id = M.MEMBER_NAME_ID  
WHERE
    M.MEMBERSHIP_ID IS NOT NULL
