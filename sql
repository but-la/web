/github/workspace/deployment/database/schema.sql
CREATE DATABASE `shortener`;

USE `shortener`;

CREATE TABLE `links` (
    `id` int(11) NOT NULL,
    `code` varchar(36) NOT NULL,
    `url` text NOT NULL,
    `expiry` datetime DEFAULT CURRENT_TIMESTAMP,
    `ip` varchar(45) DEFAULT '0.0.0.0'
);

ALTER TABLE `links`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `code` (`code`);

ALTER TABLE `links`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

CREATE TABLE `users` (
    `id`       int(11) NOT NULL,
    `username` varchar(36) NOT NULL,
    `email`    varchar(72) NOT NULL,
    `name`     varchar(36) NOT NULL,
    `password` varchar(36) NOT NULL
);

ALTER TABLE `users`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `username` (`username`);

ALTER TABLE `users`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

INSERT INTO `links` (`code`, `url`, `expiry`, `ip`) VALUES ('default', 'https://localhost:8088/shorten', NULL, NULL);
INSERT INTO `users` (`username`, `email`, `name`, `password`) VALUES ('admin', 'admin@example.com', 'Admin', 'password');
```
```markdown
/github/workspace/deployment/database/README.md
# Database Schema for Shortener Application

This SQL script is designed to set up the initial database structure needed by the Shortener application, including creating tables for storing link and user data along with their respective schema definitions.

## Overview:

- Create a new database named `shortener`.
- Switch to the `shortener` database for subsequent operations.
- Create the `links` table with the following fields:
  - `id`: Auto-incrementing integer serving as the primary key.
  - `code`: A varchar field to store the unique code associated with a URL.
  - `url`: A text field to store the original URL.
  - `expiry`: A datetime field to store the expiration time of the link.
  - `ip`: A varchar field to store the IP address that created the link.
- Create the `users` table with the following fields:
  - `id`: Auto-incrementing integer serving as the primary key.
  - `username`: A varchar field for storing the username, which must be unique.
  - `email`: A varchar field for the user's email address.
  - `name`: A varchar field for the user's name.
  - `password`: A varchar field for storing the user's password.

The script includes necessary constraints like primary keys and unique indexes to ensure data integrity.

It also populates the `links` table with a default link and the `users` table with a default admin user.

## Usage:

Run this script using a MySQL-compatible database system to initialize the database for the Shortener application. Ensure the application has necessary access to this database.

Remember to change the default entries to secure admin access and set actual redirection for the default link.