import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Tournament> tournamentList = [];

  @override
  void initState() {
    super.initState();
    _fetchTournamentList();
  }

  Future<void> _fetchTournamentList() async {
    try {
      final url = Uri.parse('http://127.0.0.1:5000/tournaments');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        //successful fetching
        final data = json.decode(response.body);
        setState(() {
          tournamentList = List<Tournament>.from(data['tournaments']
              .map((tournamentData) => Tournament.fromJson(tournamentData)));
        });
      } else {
        print("Failed to load tournament list");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _addTournament(String name) {
    try {
      final url = Uri.parse('http://127.0.0.1:5000/tournaments/add');
      final response = await http.post(
        url, 
        headers: {
          'Content-Type': 'application/json'
        },
        body: json.encode(
          {
            'name' : name,
          }
        ),
      );

      if(response.statusCode == 200) {
        print("Tournament created successfully");
      } else {
        print("Failed to add tournament");
      }
    }
    catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Scaffold(
      body: ListView.builder(
          itemCount: tournamentList.length,
          itemBuilder: (context, index) {
            return ListTile(
              //thing of the title
              title: Text(tournamentList[index].),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
      backgroundColor: Color(0xFF212121),
    );
  }
}

class Tournament {
  final String name;

  Tournament({required this.name);

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      name: json['name'],
    );
  }
}
