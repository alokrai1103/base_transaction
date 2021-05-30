/*
UPDATE
    cef_prod.source_stg_base_transaction B INNER JOIN
    Netsuite.MEMBERSHIP M
        ON B.MEMBERSHIP_ID = M.MEMBERSHIP_ID LEFT JOIN
    Netsuite.DEPARTMENTS D
        ON M.Department_Id = D.DEPARTMENT_ID LEFT JOIN
    Netsuite.LECLUB_TIER_LIST L
        ON L.LIST_ID = M.MEMBERSHIP_TIER_ID
SET
      membership_department = D.NAME
    , membership_lifecycle = M.LIFECYCLE_YEAR
    , membership_tier = L.LIST_ITEM_NAME
    , membership_parentId = M.PARENT_MEMBER_ID
*/
