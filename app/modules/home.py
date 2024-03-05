from flask import Flask, render_template, request, session, redirect, url_for
from flask_session import Session
import pymysql

from modules.init.db_con import *

def home_mod():
    if not session.get("logged_in"):
        return redirect(url_for("login"))

    user_id = session.get('user_id')

    # Connect to the database
    conn = pymysql.connect(host=db_host, user=db_user, password=db_password, database=db_name)
    cursor = conn.cursor()

    # Retrieve the character information from the database based on the user ID
    query = f"""SELECT characters.name, characters.level, characters.class, characters.experience,  resources.gold, resources.iron, resources.wood, resources.stone, resources.leather
FROM users
JOIN characters ON users.id = characters.user_id
JOIN resources ON characters.user_id = resources.user_id
WHERE users.id = {user_id};"""
    cursor.execute(query)
    character_data = cursor.fetchone()

    # Close the database connection
    cursor.close()
    conn.close()

    # Extract the character data
    character_name, character_level, character_class, character_exp, gold, iron, wood, stone, leather = character_data

    # Render the dashboard template with the character information
    return render_template('home.html', character_name=character_name, character_level=character_level, character_class=character_class, character_exp=character_exp, gold=gold, iron=iron, wood=wood, stone=stone, leather=leather)
