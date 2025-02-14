import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tournament/pages/profile.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  List<Player> players = []; // List to hold player data

  final _nameController = TextEditingController();
  final _ratingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPlayersData();
  }

  // Method to send a request to the Python backend
  Future<void> _fetchPlayersData() async {
    try {
      // print("456");
      final url = Uri.parse('http://127.0.0.1:5000/players'); // Backend URL
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
          players = List<Player>.from(
              data['players'].map((playerData) => Player.fromJson(playerData)));
        });
      } else {
        print('Failed to load players: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  // Method to handle adding a player to the backend
  Future<void> _addPlayer(String name, int rating) async {
    try {
      final url = Uri.parse('http://127.0.0.1:5000/players/add');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'rating': rating,
        }),
      );

      if (response.statusCode == 200) {
        print("Player added successfully");
      } else {
        print('Failed to add player: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  // Show dialog to add new players
  void _showCreatePlayerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.black87,
              title: Text(
                'Create Players',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 255, 254, 254)),
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                    ),
                  ),
                  TextField(
                    controller: _ratingController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 255, 254, 254)),
                    decoration: InputDecoration(
                      labelText: 'Rating',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () async {
                    final name = _nameController.text;
                    final rating = int.tryParse(_ratingController.text);

                    if (name.isEmpty || rating == null) {
                      // Handle invalid input
                      print('Invalid input');
                    } else {
                      // Add player to backend
                      print(rating);
                      await _addPlayer(name, rating);
                      _fetchPlayersData();
                      Navigator.pop(context); // Close the dialog
                    }
                  },
                  child: Text('Add Player'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Players', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF212121),
      ),
      backgroundColor: Color(0xFF212121),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = players[index];
                return Card(
                  color: Colors.grey[900],
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                    title: Text(
                      player.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Rating: ${player.rating}',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    trailing: Icon(Icons.arrow_forward, color: Colors.white),
                    onTap: () {
                      // Navigate to player profile
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(
                            playerName: player.name,
                            rating: player.rating,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreatePlayerDialog,
        backgroundColor: Colors.amber,
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}

// Model class to represent Player data
class Player {
  final String name;
  final int rating;

  Player({required this.name, required this.rating});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'],
      rating: json['rating'],
    );
  }
}
