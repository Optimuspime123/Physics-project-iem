import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Information'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('Developers'),
          const SizedBox(height: 10),
          const PersonTile(name: 'Saswatayu Sengupta', role: 'Lead Developer'),
          const PersonTile(name: 'Developer 2', role: 'WIP'),
          const PersonTile(name: 'Developer 3', role: 'WIP'),
          const SizedBox(height: 30),
          _buildSectionTitle('Physics Faculty'),
          const SizedBox(height: 10),
          const PersonTile(name: 'Faculty 1', role: 'Professor'),
          const PersonTile(name: 'Faculty 2', role: 'Professor Assistant'),
          const PersonTile(name: 'Faculty 3', role: 'Lab in-charge'),
          const SizedBox(height: 30),
          _buildSectionTitle('Credits'),
          const SizedBox(height: 10),
          _buildCredits(),
          const SizedBox(height: 40),
          Center(
            child: Image.asset(
              'lib/assets/thank-you.png',
              height: 150,
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCredits() {
    return const Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Image Credit for physics.png: Nhor Phai - Flaticon'),
            SizedBox(height: 8),
            Text('Image Credit for thank-you.png: LAFS - Flaticon'),
          ],
        ),
      ),
    );
  }
}

class PersonTile extends StatelessWidget {
  final String name;
  final String role;

  const PersonTile({
    required this.name,
    required this.role,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          radius: 25,
          backgroundColor: Color.fromARGB(255, 165, 179, 195),
          // You can use a NetworkImage for actual profile pictures
          // backgroundImage: NetworkImage('URL_TO_IMAGE'),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(role),
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      ),
    );
  }
}