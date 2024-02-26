# Database connection settings

import os

# Read MySQL password from environment variable
db_password = os.environ.get("MYSQL_PASSWORD")
db_host = "db-svc"
#db_host = "db"
db_user = "root"
#db_password = "password"
db_name = "game_db"