UPDATE
    cef_prod.source_stg_base_transaction B LEFT JOIN 
    Netsuite.TRANSACTION_LINES TL ON B.transaction_id = TL.TRANSACTION_ID LEFT JOIN
    Netsuite.ITEMS IT ON TL.ITEM_ID = IT.item_id
        AND
        CASE B.membership_item_type
            WHEN 'Primary' THEN 1
            WHEN 'Supplementary' THEN 2
            END = IT.MEMBERSHIP_ID LEFT JOIN
    Netsuite.DEPARTMENTS D ON D.DEPARTMENT_ID = TL.DEPARTMENT_ID LEFT JOIN
    Netsuite.CLASSES C ON C.CLASS_ID = TL.class_Id LEFT JOIN
    Netsuite.TRANSACTION_LINES TL_C on TL_C.COUPON_CASH_SALE_ID is not null and TL_C.COUPON_CASH_SALE_ID = B.transaction_id and TL_C.TRANSACTION_ORDER = 0
SET
      sale_type = CASE IT.ITEM_TYPE_ID
                    WHEN 1 THEN 'New Sale'
                    WHEN 2 THEN 'Renewal'
                    WHEN 3 THEN 'Late Renewal'
                    WHEN 4 THEN 'Non Renewal' END
    , transaction_department = D.name
    , sale_channel = C.NAME
    , if_complimentary = IT.COMPLEMENTARY_TYPE_ID
    , product = IT.NAME
    , net_amount = case when (TL_C.COUPON_CASH_SALE_ID is null or (TL_C.COUPON_CASH_SALE_ID is not null and ifnull(TL_C.AMOUNT,0) =0)) then case when TL.AMOUNT <0 then -TL.AMOUNT else TL.AMOUNT end else TL_C.AMOUNT END
WHERE
    IT.ITEM_TYPE_ID IN (1, 2, 3, 4)
