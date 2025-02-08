import 'package:flutter/material.dart';

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
        itemCount: 20, // You can replace this with your dynamic list
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'Player ${index + 1}',
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: const Text(
              'Player details',
              style: TextStyle(color: Colors.white),
            ),
            tileColor: index.isEven ? Colors.black : Colors.grey[800],
          );
        },
      ),
    );
  }
}
