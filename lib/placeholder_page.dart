import 'package:flutter/material.dart';

class TeamPlaceholderPage extends StatelessWidget {
  const TeamPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Team'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('The team page will be implemented here.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Use Navigator.pop to go back to the previous screen (HomePage)
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}