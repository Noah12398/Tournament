import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tournament/pages/profile.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  List<Player> players = []; // List to hold player data

  @override
  void initState() {
    super.initState();
    _fetchPlayersData();
  }

  // Method to send a request to the Python backend
  Future<void> _fetchPlayersData() async {
    try {
      final url = Uri.parse('http://127.0.0.1:5000/players'); // Replace with your Python backend URL
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response and populate the player list
        final data = json.decode(response.body);
        setState(() {
          players = List<Player>.from(data['players'].map((playerData) => Player.fromJson(playerData)));
        });
      } else {
        // Handle error response
        print('Failed to load players: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors
      print( e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Players',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF212121),
      ),
      backgroundColor: const Color(0xFF212121),
      body: ListView.builder(
        itemCount: players.length, // Use the actual length of players list
        itemBuilder: (context, index) {
          final player = players[index];
          return Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.amber,
                child: Icon(Icons.person, color: Colors.black),
              ),
              title: Text(
                player.name, // Display player name from API
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Level: ${player.level}', // Display player level from API
                style: TextStyle(color: Colors.grey[400]),
              ),
              trailing: const Icon(Icons.arrow_forward, color: Colors.white),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfileScreen(
                      playerName: player.name,
                      level: 5,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Model class to represent Player data
class Player {
  final String name;
  final int level;

  Player({required this.name, required this.level});

  // Factory method to create Player from JSON
  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'],
      level: json['level'],
    );
  }
}
