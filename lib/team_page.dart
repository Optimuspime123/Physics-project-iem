import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Information'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('Developers'),
          const SizedBox(height: 10),

          // Specific image for Saswatayu
          const PersonTile(
            name: 'Saswatayu Sengupta',
            role: 'Lead Developer',
            imageUrl: 'https://files.catbox.moe/lc4nun.JPG',
          ),

          // Others use default Adobe Stock image 
          const PersonTile(name: 'Developer 2', role: 'WIP'),
          const PersonTile(name: 'Developer 3', role: 'WIP'),

          const SizedBox(height: 30),
          _buildSectionTitle('Physics Faculty'),
          const SizedBox(height: 10),
          const PersonTile(name: 'Faculty 1', role: 'Professor'),
          const PersonTile(name: 'Faculty 2', role: 'Professor'),
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
              onPressed: () => Navigator.pop(context),
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
  final String? imageUrl;

  // Default avatar for anyone who doesn't provide an imageUrl
  static const String _defaultAvatar =
      'https://as1.ftcdn.net/jpg/03/46/59/66/1000_F_346596622_1YHt3wZ4gYRhonqYOQgPnL2wbcrA0nvr.jpg';

  const PersonTile({
    required this.name,
    required this.role,
    this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final avatarUrl =
        (imageUrl == null || imageUrl!.isEmpty) ? _defaultAvatar : imageUrl!;

    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: const Color.fromARGB(255, 165, 179, 195),
          backgroundImage: NetworkImage(avatarUrl),
          onBackgroundImageError: (_, __) {},
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(role),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      ),
    );
  }
}
