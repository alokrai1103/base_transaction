UPDATE
    cef_prod.source_stg_base_transaction  B INNER JOIN
    Netsuite.CUSTOMERS C
        ON B.customer_id = C.CUSTOMER_ID INNER JOIN
    Netsuite.SUBSIDIARIES S
        ON C.SUBSIDIARY_ID = S.SUBSIDIARY_ID INNER JOIN
    Netsuite.DEPARTMENTS D
        ON D.DEPARTMENT_ID = C.PROGRAM_DEPARTMENT_ID LEFT JOIN
    Netsuite.LEAD_TYPE_LIST L 
        ON L.LIST_ID = C.Lead_Type_Id
SET 
      subsidiary = S.COUNTRY
    , subsidiary_entity=S.NAME  
    , customer_department = D.NAME
    , lead_type = L.LIST_ITEM_NAME
    , customer_parentId = C.Parent_Id
    , pmid = C.CUSTOMER_EXTID
