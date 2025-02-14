import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> tournamentName = [];

  void _addItem() {
    setState(() {
      tournamentName.add('Items ${tournamentName.length + 1}');
    });
  }

  Widget _bodyWidget() {
    return Scaffold(
      body: ListView.builder(
          itemCount: tournamentName.length,
          itemBuilder: (context, index) {
            return ListTile(
              //thing of the title
              title: Text(tournamentName[index]),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
    );
  }
}
