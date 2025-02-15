import os
import logging
from flask import Flask, jsonify, request
from flask_cors import CORS
import psycopg2
from psycopg2 import pool
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Setup logging
logging.basicConfig(level=logging.DEBUG)

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Declare connection_pool as a global variable
connection_pool = None

# PostgreSQL connection setup
def init_db_pool():
    global connection_pool  # Reference the global variable
    try:
        connection_pool = psycopg2.pool.ThreadedConnectionPool(
            minconn=1,
            maxconn=10,  # Adjust based on use case
            host=os.getenv("DB_HOST"),
            port=os.getenv("DB_PORT"),
            dbname=os.getenv("DB_NAME"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD"),
        )
        print("Successfully connected to the database")
    except Exception as e:
        logging.error(f"Error connecting to database: {str(e)}")
        raise e

@app.route('/players', methods=['GET'])
def get_players():
    # This function would normally query the database to get players data
    try:
        connection = connection_pool.getconn()
        cursor = connection.cursor()
        cursor.execute('SELECT name, rating FROM players;')
        players_from_db = cursor.fetchall()
        cursor.close()
        connection_pool.putconn(connection)

        # Prepare the players data from the DB query
        players = [{"name": player[0], "rating": player[1]} for player in players_from_db]
        logging.info(f"Fetched {len(players)} players from the database")
        return jsonify({"players": players})
    except Exception as e:
        logging.error(f"Error fetching players: {str(e)}")
        return jsonify({"error": str(e)}), 500

@app.route('/players/add', methods=['POST'])
def add_players():
    try:
        data = request.get_json()
        player_name = data['name']
        player_rating = data['rating']
        
        connection = connection_pool.getconn()
        cursor = connection.cursor()
        cursor.execute('INSERT INTO players (name, rating) VALUES (%s, %s)', (player_name, player_rating))
        connection.commit()
        cursor.close()
        connection_pool.putconn(connection)

        # Define the new_player dictionary correctly
        new_player = {"name": player_name, "rating": player_rating}
        
        return jsonify({'message': 'Player added successfully', 'player': new_player})

    except Exception as e:
        logging.error(f"Error adding players: {str(e)}")
        return jsonify({"error": str(e)}), 500

@app.route('/tournaments', methods=['GET'])
def get_tournaments():
    try:
        connection = connection_pool.getconn()
        cursor = connection.cursor()
        cursor.execute('SELECT * FROM tournaments') #select necessary columns
        tournaments_from_db = cursor.fetchall()
        cursor.close()  
        connection_pool.putconn(connection)

        # Prepare the tournaments data from the DB query
        tournaments = [{"name": tournament[0]} for tournament in tournaments_from_db] #fetching columns
        logging.info(f"Fetched {len(tournaments)} tournaments from the database")
        return jsonify({"tournaments": tournaments})
    except Exception as e:
        logging.error(f"Error fetching tournaments: {str(e)}")
        return jsonify({"error": str(e)}), 500

@app.route('/tournaments/add', methods=['POST'])
def add_tournaments():
    try:
        data = request.get_json()
        tournament_name = data['name']
        
        connection = connection_pool.getconn()
        cursor = connection.cursor()
        cursor.execute('INSERT INTO tournaments (name) VALUES (%s)', (tournament_name,)) #add values of tourn
        connection.commit()
        cursor.close()
        connection_pool.putconn(connection)

        new_tournament = {"name": tournament_name} #json format style thingy
        
        return jsonify({'message': 'Tournament added successfully', 'tournament': new_tournament})

    except Exception as e:
        logging.error(f"Error adding tournament: {str(e)}")
        return jsonify({"error": str(e)}), 500

# Initialize the connection pool
init_db_pool()

if __name__ == '__main__':
    app.run(debug=True)
