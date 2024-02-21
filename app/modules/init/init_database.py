from flask import Flask, render_template, request, session, redirect, url_for
from flask_session import Session
import pymysql
import os

from modules.init.db_con import *

def fill_database():
    # Open and read the data.sql file
    sql_file = os.path.join(os.path.dirname(__file__), 'data.sql')
    with open(sql_file, 'r') as file:
        statements = file.read().split(';')

    # Connect to the database
    conn = pymysql.connect(host=db_host, user=db_user, password=db_password, db=db_name)
    cursor = conn.cursor()

    # Execute each SQL statement
    for statement in statements:
        # Skip empty statements
        if not statement.strip():
            continue
        # Execute the statement
        cursor.execute(statement)

    # Commit the changes
    conn.commit()
    cursor.close()
    conn.close()

def initialize_database():
    # Create the database tables if they don't exist
    conn = pymysql.connect(host=db_host, user=db_user, password=db_password)
    cursor = conn.cursor()
    cursor.execute(f"CREATE DATABASE IF NOT EXISTS {db_name}")
    cursor.execute(f"USE {db_name}")

    # Read the SQL commands from the file
    sql_file = os.path.join(os.path.dirname(__file__), 'database.sql')
    with open(sql_file, 'r') as file:
        sql_commands = file.read().split(';')

    # Execute the SQL commands
    for command in sql_commands:
        if command.strip():
            cursor.execute(command)

    cursor.close()
    conn.close()