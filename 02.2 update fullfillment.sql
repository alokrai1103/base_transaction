WITH
    fulfill_temp AS
    (
        SELECT 
              T3.Transaction_ID AS fulfill_id
            , T1.Transaction_ID
        FROM
            cef_prod.source_stg_base_transaction B INNER JOIN
            Netsuite.TRANSACTIONS T1
                ON B.transaction_id = T1.Transaction_ID INNER JOIN
            Netsuite.TRANSACTIONS T3
                ON T1.CREATED_FROM_ID = T3.CREATED_FROM_ID INNER JOIN
            Netsuite.TRANSACTION_LINES TL
                ON TL.TRANSACTION_ID = T3.TRANSACTION_ID INNER JOIN
            Netsuite.ITEMS IT
                ON TL.ITEM_ID = IT.item_id
        WHERE
            T1.CREATED_FROM_ID IS NOT NULL
            AND T3.CREATED_FROM_ID IS NOT NULL
            AND T3.TRANSACTION_TYPE = 'Item Fulfillment'
            AND IT.ITEM_TYPE_ID IN (1, 2, 3, 4)
    )

UPDATE
    cef_prod.source_stg_base_transaction B INNER JOIN
    fulfill_temp A
        ON A.Transaction_ID = B.Transaction_ID
SET
    B.fulfill_id = A.fulfill_id
