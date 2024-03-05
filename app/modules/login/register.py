from flask import Flask, render_template, request, session, redirect, url_for
from flask_session import Session
import pymysql

from modules.init.db_con import *

def register_mod():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        email = request.form['email']
        character_class = request.form['character_class']
        # Connect to the database
        conn = pymysql.connect(host=db_host, user=db_user, password=db_password, db=db_name)
        cursor = conn.cursor()

        try:
            # Check if the username already exists
            check_user_query = f"SELECT * FROM users WHERE username='{username}'"
            cursor.execute(check_user_query)
            existing_user = cursor.fetchone()

            if existing_user:
                # Username already exists, render the registration page with an error message
                return render_template('register.html', error='Username already exists')

            # Insert user into the database
            insert_user_query = f"INSERT INTO users (username, password, email) VALUES ('{username}', '{password}', '{email}')"
            cursor.execute(insert_user_query)

            # Get the user ID
            user_id = cursor.lastrowid

            # Insert default resources for the user
            insert_resources_query = f"INSERT INTO resources (user_id, gold, iron, wood, stone, leather) VALUES ({user_id}, 0, 0, 0, 0, 0)"
            cursor.execute(insert_resources_query)

            # Insert default character for the user
            insert_character_query = f"INSERT INTO characters (user_id, name, class, level) VALUES ({user_id}, '{username}', '{character_class}', 1)"
            cursor.execute(insert_character_query)

            # Commit the changes
            conn.commit()

            # Close the database connection
            cursor.close()
            conn.close()
            return redirect(url_for('login_route'))

        except Exception as e:
            # Handle any errors that occur during the database operations
            print(f"Error: {e}")
            conn.rollback()
            cursor.close()
            conn.close()

            return "Registration failed!"

    return render_template('register.html', error=None)