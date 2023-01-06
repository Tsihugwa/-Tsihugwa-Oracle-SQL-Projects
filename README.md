# -Tsihugwa-Oracle-SQL-Projects
Welcome to the Sql Command File for Online Shopping! This repository contains the code for creating and manipulating the database for an online shopping system. The database includes tables for stock, customers, bank information, and purchases.

To use this code, make sure to have the necessary Oracle tools installed and set up on your system. You will also need to change the SET SERVEROUTPUT command to match the tools you are using.

To begin, the code first drops any existing tables and sequences to avoid conflicts. It then creates the tables for stock, customer, bank, and purchase. The customer table has a primary key set as the cust_id column, and the purchase table has a primary key set as the purchase_id column.

Next, the code creates sequences for the cust_id and purchase_id columns to allow for autoincrementing values when inserting new rows. The code also includes triggers to ensure that the cust_id and purchase_id values are automatically generated before inserting new rows into the customer and purchase tables.

Finally, the code inserts sample data into each of the tables to provide an example of how to use the database.

Thank you for using this Sql Command File for Online Shopping! If you have any questions or issues, please do not hesitate to reach out.
