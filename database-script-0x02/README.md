# `seed.sql` - Database Seed Data

## Description

The `seed.sql` file contains SQL queries to populate the AirBnB clone database with sample data. This is intended to help developers quickly set up the database with test data for development or testing purposes.

This script will insert data into the following tables:

- **User**: Adds sample users, including a host, guest, and admin.
- **Property**: Adds sample properties with different attributes and relationships to users.
- **Booking**: Adds sample booking records, linked to properties and users.
- **Payment**: Adds payment records linked to bookings.
- **Review**: Adds reviews associated with properties and users.
- **Message**: Adds message data for communication between users.

## Instructions

1. **Run the Seed Script**:
   After you've set up your database schema using the `schema.sql` file, you can insert sample data into your tables by running the `seed.sql` script.

   To run the `seed.sql` file in PostgreSQL, use the following command:

   ```bash
   psql -U username -d database_name -f seed.sql
   ```
