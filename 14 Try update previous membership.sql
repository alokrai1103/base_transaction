UPDATE
    cef_prod.source_stg_base_transaction B INNER JOIN
    Netsuite.MEMBERSHIP mem_current
        ON B.membership_id = mem_current.MEMBERSHIP_ID LEFT JOIN
    Netsuite.TRANSACTIONS t_Fulfillment
        ON mem_current.ORIGINAL_LINKED_TRANSACTION_ID = t_Fulfillment.TRANSACTION_ID LEFT JOIN
    Netsuite.TRANSACTIONS t_initialSO
        ON t_Fulfillment.CREATED_FROM_ID = t_initialSO.TRANSACTION_ID LEFT JOIN 
    Netsuite.TRANSACTIONS t_opp
        ON t_initialSO.CREATED_FROM_ID = t_opp.TRANSACTION_ID LEFT JOIN
    Netsuite.MEMBERSHIP mem_previous
        ON mem_previous.MEMBERSHIP_ID = t_opp.MEMBERSHIP_LINK_ID
SET
    pre_membership_id = mem_previous.MEMBERSHIP_ID 
