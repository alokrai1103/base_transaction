UPDATE
    cef_prod.source_stg_base_transaction B INNER JOIN
    (
        SELECT
              b.transaction_ID
            , COUNT(*) AS FOC
        FROM
            cef_prod.source_stg_base_transaction b LEFT JOIN
            Netsuite.TRANSACTION_LINES tl
                ON b.transaction_id = tl.TRANSACTION_ID LEFT JOIN
            Netsuite.ITEMS it
                ON tl.ITEM_ID = it.ITEM_ID
        WHERE
            it.ITEM_ID = 411
        GROUP BY
            b.transaction_ID
    ) a 
        ON B.transaction_id = a.transaction_ID
SET
    no_foc_sale = a.FOC
