/*
UPDATE
    cef_prod.source_stg_base_transaction B INNER JOIN
    Netsuite.TRANSACTIONS T
        ON B.transaction_id = T.TRANSACTION_ID LEFT JOIN
    Netsuite.TRANSACTION_LINES TL
        ON T.TRANSACTION_ID = TL.TRANSACTION_ID LEFT JOIN
    Netsuite.ITEMS IT
        ON TL.ITEM_ID = IT.ITEM_ID LEFT JOIN
    Netsuite.ITEM_PRICES IP
        ON IP.ITEM_ID = TL.ITEM_ID
        AND IP.CURRENCY_ID = T.CURRENCY_ID
        AND TL.price_type_id = IP.ITEM_PRICE_ID LEFT JOIN
    Netsuite.CURRENCIES C
        ON C.CURRENCY_ID = IP.CURRENCY_ID
SET
      item_price_name = IP.NAME
    , item_unit_price = IP.ITEM_UNIT_PRICE
    , currency_id = C.CURRENCY_ID
    , currency_symbol = C.SYMBOL
WHERE
    IT.MEMBERSHIP_ID IN (1, 2)

*/
