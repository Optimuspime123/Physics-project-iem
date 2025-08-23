import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/team_page.dart';
import 'lab_page.dart';
import 'theory_page.dart';
import 'theme_provider.dart';

// Material 3 Animation Constants
const Duration kEntranceAnimationDuration = Duration(milliseconds: 600);
const Duration kStaggerAnimationDuration = Duration(milliseconds: 150);
const Curve kEntranceAnimationCurve = Curves.easeOutCubic;
const Curve kEmphasizedCurve = Curves.easeInOutCubicEmphasized;

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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
   final PageController _pageController = PageController(viewportFraction: 0.9);
   late Timer _timer;
   late AnimationController _entranceController;
   late AnimationController _fabController;
   late Animation<double> _fadeAnimation;
   late Animation<Offset> _slideAnimation;
   late Animation<double> _scaleAnimation;

   @override
   void initState() {
     super.initState();

     // Initialize animation controllers
     _entranceController = AnimationController(
       duration: kEntranceAnimationDuration,
       vsync: this,
     );

     _fabController = AnimationController(
       duration: const Duration(milliseconds: 300),
       vsync: this,
     );

     // Create animations
     _fadeAnimation = Tween<double>(
       begin: 0.0,
       end: 1.0,
     ).animate(CurvedAnimation(
       parent: _entranceController,
       curve: kEntranceAnimationCurve,
     ));

     _slideAnimation = Tween<Offset>(
       begin: const Offset(0, 0.1),
       end: Offset.zero,
     ).animate(CurvedAnimation(
       parent: _entranceController,
       curve: kEntranceAnimationCurve,
     ));

     _scaleAnimation = Tween<double>(
       begin: 0.95,
       end: 1.0,
     ).animate(CurvedAnimation(
       parent: _entranceController,
       curve: kEntranceAnimationCurve,
     ));

     // Start entrance animation
     _entranceController.forward();

     _timer = Timer.periodic(const Duration(seconds: 9), (Timer timer) {
       if (_pageController.hasClients) {
         int nextPage = _pageController.page!.round() + 1;
         if (nextPage >= HomePage.quotes.length) {
           nextPage = 0;
         }
         _pageController.animateToPage(
           nextPage,
           duration: const Duration(milliseconds: 400),
           curve: kEmphasizedCurve,
         );
       }
     });
   }

   @override
   void dispose() {
     _timer.cancel();
     _pageController.dispose();
     _entranceController.dispose();
     _fabController.dispose();
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
       body: AnimatedBuilder(
         animation: _entranceController,
         builder: (context, child) {
           return FadeTransition(
             opacity: _fadeAnimation,
             child: SlideTransition(
               position: _slideAnimation,
               child: ScaleTransition(
                 scale: _scaleAnimation,
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                       const SizedBox(height: 24.0),
                       _buildAnimatedSection(context, 'Theory', Icons.book, const TheoryPage(), delay: 0),
                       const SizedBox(height: 16.0),
                       _buildAnimatedSection(context, 'Lab', Icons.science, const LabPage(), delay: 1),
                       Expanded(
                         child: Center(
                           child: AnimatedBuilder(
                             animation: _entranceController,
                             builder: (context, child) {
                               return Transform.scale(
                                 scale: 0.8 + (_scaleAnimation.value * 0.2),
                                 child: Image.asset(
                                   'lib/assets/physics.png',
                                   height: 120,
                                   color: Theme.of(context).colorScheme.primary,
                                   colorBlendMode: BlendMode.srcIn,
                                 ),
                               );
                             },
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
               ),
             ),
           );
         },
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

   Widget _buildAnimatedSection(
       BuildContext context, String title, IconData icon, Widget page, {required int delay}) {
     final delayAnimation = Tween<double>(
       begin: 0.0,
       end: 1.0,
     ).animate(CurvedAnimation(
       parent: _entranceController,
       curve: Interval(
         delay * 0.1,
         0.6 + (delay * 0.1),
         curve: kEntranceAnimationCurve,
       ),
     ));

     return AnimatedBuilder(
       animation: delayAnimation,
       builder: (context, child) {
         return Transform.translate(
           offset: Offset(0, 20 * (1 - delayAnimation.value)),
           child: Opacity(
             opacity: delayAnimation.value,
             child: Transform.scale(
               scale: 0.95 + (0.05 * delayAnimation.value),
               child: _buildSection(context, title, icon, page),
             ),
           ),
         );
       },
     );
   }

   Widget _buildQuoteCard(String quote, String author) {
     return AnimatedBuilder(
       animation: _entranceController,
       builder: (context, child) {
         return Transform.scale(
           scale: 0.98 + (_scaleAnimation.value * 0.02),
           child: Card(
             margin: const EdgeInsets.symmetric(horizontal: 8.0),
             elevation: 2.0,
             color: Theme.of(context).colorScheme.surfaceContainerHighest,
             shadowColor: Theme.of(context).colorScheme.shadow,
             surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(16.0),
             ),
             child: Padding(
               padding: const EdgeInsets.all(20.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     '"$quote"',
                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                           fontStyle: FontStyle.italic,
                           color: Theme.of(context).colorScheme.onSurface,
                         ),
                     maxLines: 3,
                     overflow: TextOverflow.ellipsis,
                   ),
                   const SizedBox(height: 12),
                   Align(
                     alignment: Alignment.bottomRight,
                     child: Container(
                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                       decoration: BoxDecoration(
                         color: Theme.of(context).colorScheme.primaryContainer,
                         borderRadius: BorderRadius.circular(8),
                       ),
                       child: Text(
                         '- $author',
                         style: Theme.of(context).textTheme.labelMedium?.copyWith(
                               fontWeight: FontWeight.w600,
                               color: Theme.of(context).colorScheme.onPrimaryContainer,
                             ),
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ),
         );
       },
     );
   }

   Widget _buildFooter(BuildContext context) {
     return AnimatedBuilder(
       animation: _entranceController,
       builder: (context, child) {
         return Opacity(
           opacity: _fadeAnimation.value,
           child: Transform.translate(
             offset: Offset(0, 10 * (1 - _fadeAnimation.value)),
             child: Column(
               children: [
                 Container(
                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                   decoration: BoxDecoration(
                     color: Theme.of(context).colorScheme.surfaceContainerHighest,
                     borderRadius: BorderRadius.circular(12),
                   ),
                   child: Text(
                     'Made with ❤️ by students of section A8,',
                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
                           color: Theme.of(context).colorScheme.onSurfaceVariant,
                         ),
                     textAlign: TextAlign.center,
                   ),
                 ),
                 const SizedBox(height: 8.0),
                 OutlinedButton.icon(
                   onPressed: () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => const TeamPage()),
                     );
                   },
                   icon: const Icon(Icons.people_outline, size: 18),
                   label: const Text('see who helped!'),
                   style: OutlinedButton.styleFrom(
                     side: BorderSide(
                       color: Theme.of(context).colorScheme.outline,
                       width: 1,
                     ),
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(8),
                     ),
                   ),
                 ),
               ],
             ),
           ),
         );
       },
     );
   }
}