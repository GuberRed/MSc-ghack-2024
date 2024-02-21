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

    # Close the database connection
    cursor.close()
    conn.close()

    # Render the dashboard template with the character information
    return render_template('home.html')
