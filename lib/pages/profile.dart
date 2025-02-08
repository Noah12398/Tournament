import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  final String playerName;
  final double level;

  const UserProfileScreen({super.key, required this.playerName, required this.level});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late double level;

  @override
  void initState() {
    super.initState();
    level = widget.level;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playerName, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.amber),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.info, color: Colors.amber, size: 30),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 10),
                  Image.asset('assets/Tshirt.png', width: 100),

                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("First name", style: TextStyle(fontSize: 16, color: Colors.grey)),
            TextField(
              decoration: InputDecoration(
                hintText: widget.playerName.split(" ")[0],
                suffixText: "4/40",
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 10),
            const Text("Last name", style: TextStyle(fontSize: 16, color: Colors.grey)),
            TextField(
              decoration: InputDecoration(
                hintText: widget.playerName.split(" ").length > 1 ? widget.playerName.split(" ")[1] : "",
                suffixText: "4/40",
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text("Level", style: TextStyle(fontSize: 16, color: Colors.grey)),
                Expanded(
                  child: Slider(
                    value: level,
                    min: 0,
                    max: 100,
                    activeColor: Colors.amber,
                    inactiveColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {
                        level = value;
                      });
                    },
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 18,
                  child: Text(level.toInt().toString(),
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
