from flask import Flask, render_template, request, session, redirect, url_for
from flask_session import Session
import pymysql
import os
import time


app = Flask(__name__)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

from modules.init.db_con import *
from modules.init.init_database import *
from modules.login.login import *
from modules.login.register import *
from modules.home import *

@app.route("/", methods=["GET", "POST"])
def login_route():
    return login_mod()

@app.route("/home")
def home_route():
    return home_mod()

@app.route('/register', methods=['GET', 'POST'])
def register_route():
    return register_mod()


@app.route("/logout")
def logout():
    session.pop("logged_in", None)
    return redirect(url_for("login_route"))

if __name__ == "__main__":
    time.sleep(5)
    test_database()
    app.run(host="0.0.0.0", port=5000)

