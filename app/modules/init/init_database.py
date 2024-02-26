from flask import Flask, render_template, request, session, redirect, url_for
from flask_session import Session
import pymysql
import os

from modules.init.db_con import *

def test_database():
    # Connect to the database
    conn = pymysql.connect(host=db_host, user=db_user, password=db_password, db=db_name)
    cursor = conn.cursor()

    # Execute each SQL statement
    cursor.execute(f"SELECT * FROM users")

    # Commit the changes
    conn.commit()
    cursor.close()
    conn.close()