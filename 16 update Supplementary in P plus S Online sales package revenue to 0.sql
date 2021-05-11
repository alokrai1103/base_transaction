UPDATE
    cef_prod.source_stg_base_transaction bt INNER JOIN 
    (
        SELECT
              transaction_id
            , COUNT(*) AS c
        FROM
             cef_prod.source_stg_base_transaction
        GROUP BY
            transaction_id 
        HAVING
            COUNT(*) > 1
    ) a
        ON bt.transaction_id = a.transaction_id
        AND bt.duplicate_created_from_id IS NULL
        AND bt.sale_channel = 'Online' 
        AND bt.membership_item_type = 'Supplementary'
        AND bt.refund_id is null
SET
    bt.transaction_amount = 0
