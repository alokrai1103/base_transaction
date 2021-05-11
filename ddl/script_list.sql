DROP TABLE IF EXISTS dave_control.script_list
GO

CREATE TABLE dave_control.script_list (
      script_path              varchar(100) null
    , script_name              varchar(200) not null

    , target_database_name     varchar(100) not null
    , target_table_name        varchar(100) not null
)
GO

INSERT INTO dave_control.script_list
(
      script_path
    , script_name
    , target_database_name
    , target_table_name
)
VALUES
      ('base_transaction', '01 Truncate Base Transaction Table.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '02 Insert All Cash Sales and Invoices.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '02.1 update refund.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '02.2 update fullfillment.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '03 update Member Membership Opportunity (excluding AMEX and Online).sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '04 update Cash Sales and Invoices detail.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '05 update Customer (linked to the CS or INV) detail.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '06 update AMEX and Online Member Membership Opportunity.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '06.1 Nord update AMEX Member Membership Opportunity.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '07 update Membership (linked to CS or INV) detail.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '08 Update number of rollover FOC for membership.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '09 Update number of FOC came with sale for membership.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '10 Update CS or INV transaction amount.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '11 Update transaction amount detail.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '12 Update Finance Calendar information.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '13 Update if Customer parent is person.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '14 Try update previous membership.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '15 Update Sales Rep for CS and INV.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '15.1 update inbounce flag.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '16 update Supplementary in P plus S Online sales package revenue to 0.sql', 'cef_prod', 'source_stg_base_transaction')
    , ('base_transaction', '16.1 cdc base transaction.sql', 'cef_prod', 'source_base_transaction')
    , ('base_transaction', '16.2 truncate Netsuite base transaction.sql', 'cef_prod', 'source_base_transaction')
    , ('base_transaction', '16.3 Update Netsute base transaction.sql', 'cef_prod', 'source_base_transaction')
    , ('base_transaction', '17 Truncate Item.sql', 'cef_prod', 'source_base_transaction_item')
    , ('base_transaction', '18 Update Item.sql', 'cef_prod', 'source_base_transaction_item')
GO
