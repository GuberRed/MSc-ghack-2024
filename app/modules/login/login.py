from flask import Flask, render_template, request, session, redirect, url_for
from flask_session import Session
import pymysql

from modules.init.db_con import *

def login_mod():
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")

        conn = pymysql.connect(host=db_host, user=db_user, password=db_password, db=db_name)
        cursor = conn.cursor()
        cursor.execute(f"SELECT * FROM users WHERE username='{username}' AND password='{password}'")
        user = cursor.fetchone()
        conn.close()

        if user:
            session["logged_in"] = True
            session["user_id"] = user[0]
            return redirect(url_for("home_route"))
        else:
            return render_template("login.html", error="Invalid credentials")

    return render_template("login.html", error=None)