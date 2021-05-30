

UPDATE
    cef_prod.source_stg_base_transaction B 
    LEFT JOIN
    Netsuite.MEMBERSHIP M
        ON M.ORIGINAL_LINKED_TRANSACTION_ID = B.fulfill_id 
        LEFT JOIN
    Netsuite.DEPARTMENTS D
        ON M.Department_Id = D.DEPARTMENT_ID 
        LEFT JOIN
    Netsuite.LECLUB_TIER_LIST L
        ON L.LIST_ID = M.MEMBERSHIP_TIER_ID
SET
      B.membership_id = M.MEMBERSHIP_ID
    , B.renewal_opportunity_id = M.RENEWAL_OPPORTUNITY_ID
    , B.actual_customer_id = M.MEMBER_NAME_ID  
	, B.membership_department = D.NAME
    , B.membership_lifecycle = M.LIFECYCLE_YEAR
    , B.membership_tier = L.LIST_ITEM_NAME
    , B.membership_parentId = M.PARENT_MEMBER_ID
WHERE
    M.MEMBERSHIP_ID IS NOT NULL
