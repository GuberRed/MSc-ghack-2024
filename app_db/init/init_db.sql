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

-- Create the characters table
CREATE TABLE IF NOT EXISTS characters (
    user_id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    class VARCHAR(50) NOT NULL,
    level INT NOT NULL,
    experience INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS resources (
  user_id INT,
  gold INT DEFAULT 0,
  iron INT DEFAULT 0,
  wood INT DEFAULT 0,
  stone INT DEFAULT 0,
  leather INT DEFAULT 0,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (username, password, email) VALUES ('test', 'test', 'player1@example.com');
INSERT INTO users (username, password, email) VALUES ('player2', 'password2', 'player2@example.com');

INSERT INTO characters (user_id, name, class, level, experience) VALUES (1, 'Gfxde', 'Warrior', 1, 0);
INSERT INTO characters (user_id, name, class, level, experience) VALUES (2, 'Character', 'Rogue', 2, 0);

INSERT INTO resources (user_id, gold, iron, wood, stone, leather) VALUES (1, 100, 50, 200, 150, 10);
INSERT INTO resources (user_id, gold, iron, wood, stone, leather) VALUES (2, 1200, 520, 2200, 1250, 210);
