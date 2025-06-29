# `schema.sql` - Database Schema

## Description

This file contains the SQL schema for setting up the database for the AirBnB clone project. It defines the structure of the database, including the creation of tables, relationships, constraints, and indexes.

### Key Features:

- Defines tables for **User**, **Property**, **Booking**, **Payment**, **Review**, and **Message**.
- Includes **primary keys**, **foreign keys**, **unique constraints**, and **check constraints**.
- Implements **indexes** for better query performance on frequently queried fields.
- Ensures **referential integrity** between the tables through foreign key relationships.
- Enforces **non-null constraints** on essential attributes, such as `user_id`, `property_id`, `start_date`, etc.

## Instructions

1. **Run the Schema**:
   To set up the database schema, run the following command in your SQL client or terminal:
   ```bash
   psql -U username -d database_name -f schema.sql
   ```
