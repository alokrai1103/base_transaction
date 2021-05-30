/*
UPDATE
    cef_prod.source_stg_base_transaction B INNER JOIN
    Netsuite.TRANSACTIONS T
        ON T.TRANSACTION_ID = B.TRANSACTION_ID INNER JOIN
    Netsuite.EMPLOYEES E
        ON T.SALES_REP_ID = E.EMPLOYEE_ID
SET
      sales_rep_id = T.SALES_REP_ID
    , employee_name = E.FULL_NAME
*/
