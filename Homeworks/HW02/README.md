# HW02: Conceptual Modeling Using EER Notation

**DUE: Feb. 9, 2019 (Sat) at 11:50 PM**

A bank customer may have several savings and checking accounts at a bank, with each account having a current balance; joint accounts are allowed, but must have a primary holder. Assume that only savings accounts earn interest, and that checking accounts are charged a monthly fee.

Customers can also be issued credit cards by the bank, which have the usual information (e.g., card number, expiry date, and limit). (Note that a credit card is not the same as an ATM/debit card, which we will NOT be modeling. It is not tied to an account.)

Complication: a bank (with a name, and headquarter state) may have multiple branches (branch information includes unique branch number, address, and phone) and the earlier paragraph failed to make this distinction!

1. Develop a conceptual model of this domain, and give an EER diagram capturing as much of it as possible. For identification purposes, you can assume that banks (not their branches!) Have a unique SWIFT code (for inter-bank wire transfers), bank accounts have account numbers that are only 5-digits long, and persons have unique social security numbers.

   PLEASE USE YOUR KNOWLEDGE OF HOW YOU INTERACT WITH BANKS IN CREATING THE DIAGRAM. AND PLEASE BE SURE TO EXPRESS ALL POSSIBLE CONSTRAINTS IN THE DIAGRAM

2. Show separately any changes to parts of your EER model if one needed to keep track of the history of balances for each account (from which you can reconstruct deposit/withdrawal information).

## Submission

You can use Microsoft Word, or just draw on a piece of paper of all entities, and create ER diagram with relationship between 2 tables, then link them together by drawing from the left to right of the table. Put "disjoint" or "cover" if there is an "IS A" relationship.
