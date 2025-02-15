import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Tournament> tournamentList = [];
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchTournamentList();
  }

  Future<void> _fetchTournamentList() async {
    try {
      final url = Uri.parse(
          'http://127.0.0.1:5000/tournaments'); // Use 10.0.2.2 for emulator
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        if (data == null || data['tournaments'] == null) {
          print("No tournaments found, setting empty list.");
          setState(() {
            tournamentList = [];
          });
          return;
        }
        setState(() {
          tournamentList = List<Tournament>.from(data['tournaments']
              .map((tournamentData) => Tournament.fromJson(tournamentData)));
        });
      } else {
        print("Failed to load tournament list");
      }
    } catch (e) {
      print("Error fetching tournaments: $e");
    }
  }

  Future<void> _addTournament(String name) async {
    try {
      final url = Uri.parse('http://127.0.0.1:5000/tournaments/add');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        print("Tournament created successfully");
        _fetchTournamentList(); // Refresh list after adding
      } else {
        print("Failed to add tournament");
      }
    } catch (e) {
      print("Error adding tournament: $e");
    }
  }

  void _showCreateTournamentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: Text('Create Tournament',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
          content: TextField(
            controller: _nameController,
            style: TextStyle(fontSize: 18, color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black),
              onPressed: () async {
                final name = _nameController.text.trim();
                if (name.isEmpty) {
                  print('Invalid input');
                  return;
                }
                await _addTournament(name);
                if (!context.mounted) return;
                Navigator.pop(context);
              },
              child: Text('Add Tournament'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tournaments')),
      body: _bodyWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateTournamentDialog,
        child: Icon(Icons.add),
      ),
      backgroundColor: Color(0xFF212121),
    );
  }

  Widget _bodyWidget() {
    return ListView.builder(
      itemCount: tournamentList.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.grey[900],
          child: ListTile(
            title: Text(
              tournamentList[index].name,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}

class Tournament {
  final String name;

  Tournament({required this.name});

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(name: json['name']);
  }
}
