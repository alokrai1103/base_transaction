UPDATE
    cef_prod.source_stg_base_transaction B INNER JOIN
    Netsuite.TReportingCalender C
        ON B.transaction_date BETWEEN C.`Week Start Date` AND C.`Week Finish Date`
SET
      finance_year = `Year`
    , finance_month = `Month`
    , finance_week_no = `Month Week No`
    , finance_year_week_no = `Year Week No`
