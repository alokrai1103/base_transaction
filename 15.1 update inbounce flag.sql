update cef_prod.source_stg_base_transaction B LEFT JOIN
Netsuite.SUPPORT_INCIDENTS i ON i.company_id= B.customer_id and i.AP_CASE_SUBTYPE_ID=42 and i.CREATE_DATE between DATE_SUB(B.transaction_date, INTERVAL 10 DAY) and B.transaction_date LEFT JOIN
Netsuite.CASE_SUBTYPE cs ON cs.list_id = i.ap_case_subtype_id and cs.LIST_ID=42
set Inbound= Case when (ifnull(cs.list_id,0)=42 or B.sale_channel='Inbound' )then 1 else 0 end