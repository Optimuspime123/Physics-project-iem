import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/team_page.dart';
import 'theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const List<String> quotes = [
    "The man who does not read books has no advantage over the one who cannot read them.",
    "Teachers can open the door, but you must enter it yourself.",
    "Education is the passport to the future, for tomorrow belongs to those who prepare for it today.",
    "Don’t let what you cannot do interfere with what you can do.",
    "A person who never made a mistake never tried anything new.",
    "Procrastination makes easy things hard and hard things harder.",
  ];

  static const List<String> authors = [
    "Mark Twain",
    "Chinese Proverb",
    "Malcolm X",
    "John Wooden",
    "Albert Einstein",
    "Mason Cooley"
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 9), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.round() + 1;
        if (nextPage >= HomePage.quotes.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Image.asset('lib/assets/iemlogo.png', height: 85),
            ),
            const SizedBox(width: 8),
            const Flexible(
              child: Text(
                'IEM Salt Lake Physics',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.themeMode == ThemeMode.dark
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 24.0),
            _buildSection(context, 'Theory', Icons.book, const TheoryPage()),
            const SizedBox(height: 16.0),
            _buildSection(context, 'Lab', Icons.science, const LabPage()),
            Expanded(
              child: Center(
                child: Image.asset(
                  'lib/assets/physics.png',
                  height: 120,
                  color: Theme.of(context).colorScheme.primary,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(
              height: 150,
              child: PageView.builder(
                itemCount: HomePage.quotes.length,
                controller: _pageController,
                itemBuilder: (context, index) {
                  return _buildQuoteCard(
                      HomePage.quotes[index], HomePage.authors[index]);
                },
              ),
            ),
            const SizedBox(height: 16.0),
            _buildFooter(context),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, String title, IconData icon, Widget page) {
    return FilledButton.tonal(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(String quote, String author) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '"$quote"',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '- $author',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Text(
          'Made with ❤️ by students section A8,',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 4.0),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TeamPage()),
            );
          },
          child: const Text('see who helped!'),
        ),
      ],
    );
  }
}

class TheoryPage extends StatelessWidget {
  const TheoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theory Section'),
      ),
      body: const Center(
        child: Text('This is the Theory section page.'),
      ),
    );
  }
}

class LabPage extends StatelessWidget {
  const LabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Section'),
      ),
      body: const Center(
        child: Text('This is the Lab section page.'),
      ),
    );
  }
}