UPDATE
    cef_prod.source_stg_base_transaction B INNER JOIN
    (
        SELECT
              B.TRANSACTION_ID
            , M.MEMBERSHIP_ID
            , SUM(CASE WHEN E.ROLLED_OVER_DATE IS NOT NULL THEN 1 ELSE 0 END) AS FOCsRolledover
        FROM   
            cef_prod.source_stg_base_transaction B INNER JOIN
            Netsuite.MEMBERSHIP M
                ON B.membership_id = M.MEMBERSHIP_ID LEFT JOIN
            Netsuite.ENTITLEMENT E
                ON E.MEMBERSHIP_ID = M.MEMBERSHIP_ID
                AND E.ENTITLEMENT_TYPE_ID = 1
        GROUP BY
              B.TRANSACTION_ID
            , M.MEMBERSHIP_ID
    ) a
        ON a.MEMBERSHIP_ID = B.membership_id
SET
    no_foc_rolledover = a.FOCsRolledover
