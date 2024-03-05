from flask import Flask, render_template, request, session, redirect, url_for
from flask_session import Session
import pymysql
import random
import json

from modules.init.db_con import *

# Function to calculate level and remaining experience
def calculate_level_and_remaining_exp(experience,level):
    # Load level information from levels.json
    with open('levels.json', 'r') as file:
        levels_data = json.load(file)
    
    levels = levels_data['levels']
    #get info about next level
    next_level = level + 1

    if next_level in levels:
        next_level_info = levels[next_level]
        print(next_level)
    
    for level_info in levels:
        if next_level == level_info['level']:
            experience_required = level_info['experience_required']
            if experience >= experience_required:
                level += 1
                experience -= experience_required
            else:
                break
    
    return level, experience

# Function to calculate experience and resource gains
def calculate_gains(gold, iron, wood, stone, leather):
    # Calculate experience gain
    experience_gain = random.randint(20, 100)

    # Calculate resource gains
    gold_gain = gold+random.randint(10, 50)
    iron_gain = iron+random.randint(5, 20)
    wood_gain = wood+random.randint(5, 20)
    stone_gain = stone+random.randint(5, 20)
    leather_gain = leather+random.randint(5, 20)

    return experience_gain, gold_gain, iron_gain, wood_gain, stone_gain, leather_gain

def dungeon_enter_mod():
    if not session.get("logged_in"):
        return redirect(url_for("login_route"))

    user_id = session.get('user_id')

    # Connect to the database and retrieve character information
    conn = pymysql.connect(host=db_host, user=db_user, password=db_password, db=db_name)
    cursor = conn.cursor()

    # Retrieve the character information from the database based on the user ID
    query = f"""SELECT characters.level, characters.experience, resources.gold, resources.iron, resources.wood, resources.stone, resources.leather
    FROM users
    JOIN characters ON users.id = characters.user_id
    JOIN resources ON characters.user_id = resources.user_id
    WHERE users.id = {user_id};"""
    cursor.execute(query)
    character_data = cursor.fetchone()

    # Extract the character data
    level, experience, gold, iron, wood, stone, leather = character_data

    # Generate random events/encounters
    # For simplicity, let's assume the character always successfully completes the dungeon
    # and gains experience and resources
    experience_gain, gold_gain, iron_gain, wood_gain, stone_gain, leather_gain = calculate_gains(gold, iron, wood, stone, leather)

    # Calculate the new experience points and level
    new_experience = experience + experience_gain
    new_level, remaining_experience = calculate_level_and_remaining_exp(new_experience,level)

    # Update the character's experience, level, and resource levels in the database
    update_query = f"""UPDATE characters
                       SET experience = {remaining_experience},
                           level = {new_level}
                       WHERE user_id = {user_id}"""
    cursor.execute(update_query)

    update_resources_query = f"""UPDATE resources
                                 SET gold = {gold_gain},
                                     iron = {iron_gain},
                                     wood = {wood_gain},
                                     stone = {stone_gain},
                                     leather = {leather_gain}
                                 WHERE user_id = {user_id}"""
    cursor.execute(update_resources_query)

    # Commit the changes and close the database connection
    conn.commit()
    cursor.close()
    conn.close()

    # Redirect back to the home page after the dungeon action
    return redirect(url_for("home_route"))