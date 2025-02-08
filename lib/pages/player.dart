import 'package:flutter/material.dart';
import 'package:tournament/pages/profile.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({Key? key}) : super(key: key);

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
        itemCount: 20, // Replace this with your actual player list length
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.amber,
                child: Icon(Icons.person, color: Colors.black),
              ),
              title: Text(
                'Player ${index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Level: ${(index + 1) * 5}',
                style: TextStyle(color: Colors.grey[400]),
              ),
              trailing: const Icon(Icons.arrow_forward, color: Colors.white),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfileScreen(playerName: 'Player ${index + 1}', level: (index + 1) * 5),
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
