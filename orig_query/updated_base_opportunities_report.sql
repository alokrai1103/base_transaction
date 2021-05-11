SELECT o.TRANSACTION_ID,m.MEMBERSHIP_ID, o.RENEWAL_DUE_DATE, o.CLOSED,o.EXPECTED_CLOSE,o.STATUS ,s.NAME as COUNTRY,d.NAME as Department,m.MEMBERSHIP_TYPE_ID
,o.OPP_LIFECYCLE_YEAR as Tenure , cl.NAME as Opp_Sales_Channel, so.sale_channel as Renew_Sales_Channel
,it.COMPLEMENTARY_TYPE_ID as If_Comp
,c.PMID
,CUSTOMER_ID
,iton.name as Opportunity_Product
,iton.ONLINE_0 as If_Online_Enabled
,tl_price.GROSS_AMOUNT as Gross_Amount
,case when cur.SYMBOL is not null then cur.SYMBOL else cur_opp.SYMBOL end  as Currency
,c.Member_Hash_Key
,case when it.membership_id = 1 then 'Primary' when it.membership_id = 2 then 'Supplementary' end as Membership_Type
,o.PARTNER_PUBLIC_CATEGORY_ID
,o.BUSINESS_CATEGORY_ID
,o.BUSINESS_CATEGORY_PRICE_LEV_ID
FROM 
    Netsuite.OPPORTUNITIES o inner join
    Netsuite.MEMBERSHIP m  on m.MEMBERSHIP_ID=o.MEMBERSHIP_LINK_ID inner join
    Netsuite.DEPARTMENTS d on d.DEPARTMENT_ID=m.Department_Id inner join
    Netsuite.CUSTOMERS c on c.CUSTOMER_ID=m.MEMBER_NAME_ID inner join
    Netsuite.SUBSIDIARIES s on s.SUBSIDIARY_ID=c.SUBSIDIARY_ID inner join 
    Netsuite.TRANSACTION_LINES tl on tl.TRANSACTION_ID= o.TRANSACTION_ID inner join
    Netsuite.ITEMS it on tl.ITEM_ID = it.ITEM_ID and it.membership_id in (1,2) left join
    Netsuite.TRANSACTION_LINES tlon on o.TRANSACTION_ID = tlon.TRANSACTION_ID and tlon.TRANSACTION_ORDER  = 1  left join
    Netsuite.ITEMS iton on iton.TYPE_NAME ='Item Group' and iton.ITEM_ID = tlon.ITEM_ID left join
    Netsuite.TRANSACTION_LINES tl_price on o.TRANSACTION_ID = tl_price.TRANSACTION_ID and tl_price.TRANSACTION_ORDER = 0 left join 
    Netsuite.ITEM_PRICES ip ON ip.ITEM_ID = tl.ITEM_ID
        AND ip.CURRENCY_ID = o.CURRENCY_ID
        AND tl.price_type_id = ip.ITEM_PRICE_ID   left JOIN 
    Netsuite.CURRENCIES cur ON cur.CURRENCY_ID = ip.CURRENCY_ID left Join
    Netsuite.CURRENCIES cur_opp on cur_opp.CURRENCY_ID = o.CURRENCY_ID left join 
    Netsuite.CLASSES cl on cl.CLASS_ID = tl.class_Id left join 
 (  Select t.CREATED_FROM_ID, Case when bt.sale_channel = 'Inbound' then 'Inbound' when bt.sale_channel = 'Telesales' and bt.inbound = 1 then 'Inbound' 
        Else  bt.sale_channel
         end as  sale_channel
From Netsuite.base_transaction bt
inner join Netsuite.TRANSACTIONS t on bt.sale_order_id = t.TRANSACTION_ID
Where  bt.sale_order_id is not null and t.CREATED_FROM_ID is not null and bt.refund_id is null
and bt.sale_channel is not null
) so  on  so.CREATED_FROM_ID = o.TRANSACTION_ID 


Group by o.TRANSACTION_ID,m.MEMBERSHIP_ID, o.RENEWAL_DUE_DATE, o.CLOSED,o.EXPECTED_CLOSE,o.STATUS ,s.NAME ,d.NAME ,m.MEMBERSHIP_TYPE_ID
,o.OPP_LIFECYCLE_YEAR  , cl.NAME , so.sale_channel 
,it.COMPLEMENTARY_TYPE_ID
,c.PMID
,CUSTOMER_ID
,iton.name 
,iton.ONLINE_0 
,tl_price.GROSS_AMOUNT 
,case when cur.SYMBOL is not null then cur.SYMBOL else cur_opp.SYMBOL end
,c.Member_Hash_Key
,case when it.membership_id = 1 then 'Primary' when it.membership_id = 2 then 'Supplementary' end 
,o.PARTNER_PUBLIC_CATEGORY_ID
,o.BUSINESS_CATEGORY_ID
,o.BUSINESS_CATEGORY_PRICE_LEV_ID
