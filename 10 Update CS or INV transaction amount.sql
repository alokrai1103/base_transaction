/*
Update
    cef_prod.source_stg_base_transaction B INNER JOIN
    Netsuite.TRANSACTIONS T
        ON B.transaction_id = T.TRANSACTION_ID LEFT JOIN
    Netsuite.TRANSACTION_LINES TL
        ON T.TRANSACTION_ID = TL.TRANSACTION_ID LEFT JOIN
    Netsuite.ITEM_PRICES IP
        ON IP.ITEM_ID = TL.ITEM_ID LEFT JOIN
    Netsuite.CURRENCIES C
        ON C.CURRENCY_ID = IP.CURRENCY_ID LEFT JOIN
    Netsuite.PAYMENT_METHODS PM 
        ON PM.PAYMENT_METHOD_ID = TL.PAYMENT_METHOD_ID LEFT JOIN
    Netsuite.TRANSACTION_LINES TL_C 
        ON TL_C.COUPON_CASH_SALE_ID is not null and TL_C.COUPON_CASH_SALE_ID = B.transaction_id and TL_C.TRANSACTION_ORDER = 0
SET
    transaction_amount = case when TL_C.COUPON_CASH_SALE_ID is null then TL.AMOUNT when TL_C.COUPON_CASH_SALE_ID is not null and ifnull(TL_C.AMOUNT,0) =0 then TL.AMOUNT   else TL_C.AMOUNT End
   ,payment_method = PM.NAME

WHERE 
    TL.TRANSACTION_ORDER = 0 
 */
