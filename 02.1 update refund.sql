WITH
    refund AS
    (
    Select B.TRANSACTION_ID ,T2.transaction_ID as Refund_ID,T2.TRANDATE as Refund_Date, TL.AMOUNT
    FROM
    cef_prod.source_stg_base_transaction B INNER JOIN
    Netsuite.TRANSACTIONS T2
        ON B.TRANSACTION_ID = T2.CREATED_FROM_ID
        AND T2.TRANSACTION_TYPE IN ('Credit Memo', 'Cash Refund') INNER JOIN
    Netsuite.TRANSACTION_LINES TL 
        ON T2.TRANSACTION_ID = TL.TRANSACTION_ID  INNER JOIN 
    Netsuite.ITEMS IT 
        ON IT.ITEM_ID = TL.ITEM_ID and IT.ITEM_TYPE_ID in (1,2,3,4)

   
    )
    
    
UPDATE
    cef_prod.source_stg_base_transaction B INNER JOIN
    refund R on B.transaction_ID = R.TRANSACTION_ID
    
SET
      B.refund_id = R.Refund_ID
    , B.refund_date = R.Refund_Date
    , B.refund_net_amount = case when R.AMOUNT <0 then R.AMOUNT else -R.AMOUNT end 
    