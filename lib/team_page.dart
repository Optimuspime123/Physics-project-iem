import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Information'),
      ),
 body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
 crossAxisAlignment: CrossAxisAlignment.start,
          children: [
 const Text(
 'Developers',
 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
 ),
 const SizedBox(height: 10),
 // Developer List
 Column(
 crossAxisAlignment: CrossAxisAlignment.start,
 children: const [
 PersonTile(name: 'Developer 1'),
 PersonTile(name: 'Developer 2'),
 PersonTile(name: 'Developer 3'),
 ],
 ),
 const SizedBox(height: 30),
 const Text(
 'Physics Faculty',
 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
 ),
 const SizedBox(height: 10),
 // Physics Faculty List
 Column(
 crossAxisAlignment: CrossAxisAlignment.start,
 children: const [
 PersonTile(name: 'Faculty 1'),
 PersonTile(name: 'Faculty 2'),
 PersonTile(name: 'Faculty 3'),
 ],
 ),
 const SizedBox(height: 30),
 const Text(
 'Credits',
 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
 ),
 const SizedBox(height: 10),
 // Credits Section
 const Column(
 crossAxisAlignment: CrossAxisAlignment.start,
 children: [
 Text('Image Credit for physics.png: Nhor Phai - Flaticon'), 
 Text('Image Credit for thank-you.png: LAFS - Flaticon'), 
 ],
 ),
          const SizedBox(height: 20),
          Center(
            child: Image.asset('lib/assets/thank-you.png'),
 ),

 Expanded( 
 child: Container(), // Dummy container to push content up
 ),
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
      ),
    );
  }
}

class PersonTile extends StatelessWidget {
  final String name;

  const PersonTile({required this.name, super.key});

 @override
  Widget build(BuildContext context) {
 return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
 children: [
 CircleAvatar(
                radius: 20, // Placeholder for profile picture
                backgroundColor: const Color.fromARGB(255, 165, 179, 195),
 ),
 const SizedBox(width: 10),
 Text(name),
 ],
 ),
 );
  }
}