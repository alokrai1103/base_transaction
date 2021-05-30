---- WHEN CREATED_FROM_ID IS NOT NULL for INVOICE & CASH SALE

UPDATE
    Base_Transaction B 
        INNER JOIN
    TRANSACTIONS T1
        ON B.sale_order_id = T1.CREATED_FROM_ID
SET
    B.fulfill_id = T1.Transaction_ID 

WHERE
            B.sale_order_id IS NOT NULL
            AND T1.CREATED_FROM_ID IS NOT NULL
            AND T1.TRANSACTION_TYPE = 'Item Fulfillment'



---- WHEN BOTH CREATED_FROM_ID & DUPLICATE_CREATED_FROM_ID IS NULL for INVOICE & CASH SALE

	UPDATE
    Base_Transaction B 
        INNER JOIN
    (
        SELECT
              B.TRANSACTION_ID
            , t_ful.TRANSACTION_ID as fulfill_id
        FROM
			Base_Transaction B 
			    INNER JOIN
			TRANSACTIONS T 
				ON T.duplicate_created_from_id = B.transaction_id 
				AND T.TRANSACTION_TYPE = 'Sales Order' 
				INNER JOIN
            TRANSACTIONS t_ful 
				ON t_ful.CREATED_FROM_ID = T.TRANSACTION_ID 
				AND t_ful.TRANSACTION_TYPE = 'Item Fulfillment' 
				
        WHERE
            T.TRANSACTION_TYPE = 'Sales Order'
            AND t_ful.TRANSACTION_TYPE = 'Item Fulfillment'
    ) A
        ON A.TRANSACTION_ID = B.transaction_id
            
	SET
      B.fulfill_id = A.fulfill_id 

	--- WHEN BOTH DUPLICATE_CREATED_FROM_ID IS NOT NULL for INVOICE & CASH SALE

	UPDATE
    Base_Transaction B 
        INNER JOIN
    (
        SELECT
              B.TRANSACTION_ID
			, t_ful.TRANSACTION_ID as fullfill_id
           
        FROM  
			Base_Transaction B 
			    INNER JOIN
            TRANSACTIONS t_ful 
				ON t_ful.TRANSACTION_TYPE = 'Item Fulfillment' 
				AND t_ful.CREATED_FROM_ID = B.duplicate_created_from_id 
        WHERE
            B.duplicate_created_from_id is not null
            
    ) A
        ON A.TRANSACTION_ID = B.transaction_id
	SET
		B.fulfill_id = A.fulfill_id     
