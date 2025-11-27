SQL Folder

This folder contains all PostgreSQL scripts used to build and populate the Room Rental Management System (RRMS) database.

Files Included

schema.sql
Defines all database tables, keys, and constraints.

constraints.sql
Contains PRIMARY KEY, FOREIGN KEY, UNIQUE, and CHECK constraints.

indexes.sql
Indexes created to improve query performance.

seed_data.sql
Sample dataset (50–200 rows) for testing queries and generating reports.

sample_queries.sql
Demonstration queries used in the final video and project report.

How to Use
psql -d room_rental_management -f schema.sql
psql -d room_rental_management -f constraints.sql
psql -d room_rental_management -f indexes.sql
psql -d room_rental_management -f seed_data.sql

