import os
import logging
from flask import Flask, jsonify, request
from flask_cors import CORS
import psycopg2
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Setup logging
logging.basicConfig(level=logging.DEBUG)

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# PostgreSQL connection setup
def get_db_connection():
    try:
        connection = psycopg2.connect(
            host=os.getenv("DB_HOST"),
            port=os.getenv("DB_PORT"),
            dbname=os.getenv("DB_NAME"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD"),
        )
        # print(os.getenv("DB_PASSWORD"))
        # print("dfvsdfgsdg")
        print("Successfully connected to the database")
        return connection
    except Exception as e:
        logging.error(f"Error connecting to database: {str(e)}")
        raise e

@app.route('/players', methods=['GET'])
def get_players():
    # This function would normally query the database to get players data
    try:
        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute('SELECT name, rating FROM players;')
        players_from_db = cursor.fetchall()
        cursor.close()
        connection.close()

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
        
        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute('INSERT INTO players (name, rating) VALUES (%s, %s)', (player_name, player_rating))
        connection.commit()
        cursor.close()
        connection.close()

        # Define the new_player dictionary correctly
        new_player = {"name": player_name, "rating": player_rating}
        
        return jsonify({'message': 'Player added successfully', 'player': new_player})  # ✅ No comma at the end

    except Exception as e:
        logging.error(f"Error adding players: {str(e)}")
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
