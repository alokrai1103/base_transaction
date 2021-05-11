INSERT INTO  cef_prod.source_base_transaction_item
(
      transaction_id
    , membership_id
    , membership_item_type
    , is_parent
    , item_id
    , item_name
    , item_memo
    , type_name
) 
SELECT
      transaction_id
    , membership_id
    , membership_item_type
    , is_parent
    , item_id
    , item_name
    , item_memo
    , type_name
FROM
    (
        SELECT
              b.transaction_id
            , b.membership_id
            , b.membership_item_type
            , 1 AS is_parent
            , it.ITEM_ID AS item_id
            , it.NAME AS item_name
            , tl.MEMO AS item_memo
            , it.TYPE_NAME AS type_name
        FROM
            cef_prod.source_vw_base_transaction_current b INNER JOIN
            Netsuite.TRANSACTION_LINES tl ON b.transaction_id = tl.TRANSACTION_ID INNER JOIN
            Netsuite.ITEMS it ON it.ITEM_ID = tl.ITEM_ID LEFT JOIN 
            (
                SELECT
                      transaction_id
                    , COUNT(*) AS c
                FROM
                    cef_prod.source_vw_base_transaction_current
                GROUP BY
                    transaction_id 
                HAVING
                    COUNT(*) > 1
            ) onl_combo ON onl_combo.transaction_id = b.transaction_id
        WHERE
            it.TYPE_NAME = 'Item Group'
            AND onl_combo.transaction_id IS NULL

        UNION ALL
        -- Item
        SELECT
              b.transaction_id
            , b.membership_id
            , b.membership_item_type
            , 0 AS is_parent
            , it.ITEM_ID AS item_id
            , it.NAME AS item_name
            , tl.MEMO AS item_memo
            , it.TYPE_NAME AS type_name
        FROM
            cef_prod.source_vw_base_transaction_current b INNER JOIN
            Netsuite.TRANSACTION_LINES tl ON b.transaction_id = tl.TRANSACTION_ID INNER JOIN
            Netsuite.ITEMS it ON it.ITEM_ID = tl.ITEM_ID LEFT JOIN
            (
                SELECT
                      transaction_id
                    , COUNT(*) AS c
                FROM
                    cef_prod.source_vw_base_transaction_current
                GROUP BY
                    transaction_id 
                HAVING
                    COUNT(*) >1 
            ) onl_combo ON onl_combo.transaction_id = b.transaction_id
        WHERE
            it.TYPE_NAME NOT IN (  'Sales Tax Item'
                                 , 'Item Group'
                                 , 'End of Item Group')
            AND onl_combo.transaction_id IS NULL
    ) A
