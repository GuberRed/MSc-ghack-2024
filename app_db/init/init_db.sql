-- Create the database
CREATE DATABASE IF NOT EXISTS game_db;

-- Use the database
USE game_db;

-- Create the users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

INSERT INTO users (username, password, email) VALUES ('test', 'test', 'player1@example.com');
INSERT INTO users (username, password, email) VALUES ('player2', 'password2', 'player2@example.com');