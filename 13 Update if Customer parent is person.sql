UPDATE
    cef_prod.source_stg_base_transaction B INNER JOIN
    Netsuite.CUSTOMERS C
        ON C.CUSTOMER_ID = B.customer_parentId
SET
    parent_is_person = C.Is_Person
