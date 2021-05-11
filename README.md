# base_transaction
Set of queries used to store all the scripts relating to the creation of the BaseTransactionReport

How to update the script list for Snap Logic:
1. Update the `<project_directory>/ddl/script_list.sql` such that all necessary files are on the list.
* Order is not important
* The filename does not need to include the file order
2. Save the file. And then `execute`/`run` the whole script.
3. Update the `<project_directory>/script.sql`
* Order is important here
* The filename should be exactly the same (case sensitive), including the file type (.sql)
4. Save the file. And then `execute`/`run` the whole script.
