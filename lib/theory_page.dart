import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData, rootBundle;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TheoryPage extends StatefulWidget {
  const TheoryPage({super.key});

  @override
  State<TheoryPage> createState() => _TheoryPageState();
}

class _TheoryPageState extends State<TheoryPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  // ----------------------- MODULE DATA -----------------------
  // study material added hhehehehe
  static final List<ModuleItem> _modules = [
    ModuleItem(
      number: 1,
      title: 'Mechanics',
      lectureHours: 8,
      sections: [
        ModuleSection(
          heading: 'Part A: Vector Calculus',
          bullets: [
            'Representation of a vector',
            'Important definitions; resolution of a vector into components',
            'Product of two vectors; triple product',
            'Scalar & vector fields; partial derivative of vectors',
            'Gradient of a scalar field; divergence of a vector field',
            'Curl of a vector field; curl in rotational motion context',
          ],
        ),
        ModuleSection(
          heading: 'Part B: Classical Mechanics',
          bullets: [
            'Inertial & non-inertial frames of reference',
            'Friction; constraints with friction; conservation laws',
            'Rigid body; angular velocity vector; moment of inertia',
            'Acceleration of a rigid body rolling down an inclined plane',
          ],
        ),
      ],
      academiaLinks: const [
        LinkItem(
          label: 'International Academia (MIT Physics)',
          url: 'https://catalog.mit.edu/subjects/8/',
          kind: LinkKind.academia,
        ),
        LinkItem(
          label: 'AICTE Model Curriculum (ECE)',
          url: 'https://www.aicteindia.org/sites/default/files/Model_Curriculum/Final_ECE.pdf',
          kind: LinkKind.academia,
        ),
      ],
      industryLinks: const [
        LinkItem(
          label: 'Industry Mapping: MATLAB',
          url: 'https://www.mathworks.com/products/matlab.html',
          kind: LinkKind.industry,
        ),
      ],
      textbooks: const [
        BookItem(
          title: 'Engineering Physics — Sujay Kumar Bhattacharya (McGraw Hill), Chapter 1',
          storeUrl: 'https://www.amazon.in/Engineering-Physics-Sujay-Kumar-Bhattacharya/dp/9353164907',
        ),
      ],
      labAssignments: const [
        'Determine the rigidity modulus of the material of a wire (Dynamic method).',
        'Determine the rigidity modulus of the material of a wire (Static method).',
        'Determine acceleration due to gravity using a bar pendulum.',
      ],
    ),
    ModuleItem(
      number: 2,
      title: 'Oscillations',
      lectureHours: 5,
      sections: [
        ModuleSection(
          heading: 'Oscillations',
          bullets: [
            'Relation between SHM and circular motion; DE of SHM',
            'Characteristics & energy of SHM; conservation of energy',
            'Free/undamped and damped vibrations; solution & analysis',
            'Electrical analogy for SHM/damped vibration',
            'Forced vibration; resonance; energy; sharpness & quality factor',
            'Forced vibration in an LCR circuit',
          ],
        ),
      ],
      academiaLinks: const [
        LinkItem(
          label: 'International Academia (MIT Physics)',
          url: 'https://catalog.mit.edu/subjects/8/',
          kind: LinkKind.academia,
        ),
        LinkItem(
          label: 'AICTE Model Curriculum (ECE)',
          url: 'https://www.aicteindia.org/sites/default/files/Model_Curriculum/Final_ECE.pdf',
          kind: LinkKind.academia,
        ),
      ],
      industryLinks: const [
        LinkItem(
          label: 'Industry Mapping: MATLAB',
          url: 'https://www.mathworks.com/products/matlab.html',
          kind: LinkKind.industry,
        ),
      ],
      textbooks: const [
        BookItem(
          title: 'Engineering Physics — Sujay Kumar Bhattacharya (McGraw Hill), Chapter 2',
          storeUrl: 'https://www.amazon.in/Engineering-Physics-Sujay-Kumar-Bhattacharya/dp/9353164907',
        ),
      ],
      labAssignments: const [
        'Generate parametric oscillations in a string using Melde’s experimental setup.',
      ],
    ),
    ModuleItem(
      number: 3,
      title: 'Optics',
      lectureHours: 10,
      sections: [
        ModuleSection(
          heading: 'Interference',
          bullets: [
            'Young’s double-slit experiment; resultant intensity; conservation of energy',
            'Fringe width; fringe shape; conditions for interference',
            'Coherent sources; Fresnel’s biprism; displacement of fringes',
            'Phase change on reflection; thin films (uniform & wedge); Newton’s rings',
          ],
        ),
        ModuleSection(
          heading: 'Diffraction',
          bullets: [
            'Interference vs diffraction; Fraunhofer single & double slit',
            'Diffraction by plane grating; Rayleigh’s criterion; resolving power; applications',
          ],
        ),
        ModuleSection(
          heading: 'Laser',
          bullets: [
            'Characteristics; absorption & emission; working principle; population inversion',
            'Laser system components; optical resonator & Q; threshold condition',
            'Typical lasers; applications',
          ],
        ),
      ],
      academiaLinks: const [
        LinkItem(
          label: 'International Academia (MIT Physics)',
          url: 'https://catalog.mit.edu/subjects/8/',
          kind: LinkKind.academia,
        ),
        LinkItem(
          label: 'AICTE Model Curriculum (ECE)',
          url: 'https://www.aicteindia.org/sites/default/files/Model_Curriculum/Final_ECE.pdf',
          kind: LinkKind.academia,
        ),
      ],
      industryLinks: const [
        LinkItem(
          label: 'Industry Mapping: MATLAB',
          url: 'https://www.mathworks.com/products/matlab.html',
          kind: LinkKind.industry,
        ),
      ],
      textbooks: const [
        BookItem(
          title: 'Physics — B. K. Pandey, Manoj K. Harbola et al. (Cengage), Chapter 2',
          storeUrl: 'https://www.amazon.in/Physics-B-K-Pandey/dp/8131508020',
        ),
        BookItem(
          title: 'Engineering Physics — Sujay Kumar Bhattacharya (McGraw Hill), Chapter 3',
          storeUrl: 'https://www.amazon.in/Engineering-Physics-Sujay-Kumar-Bhattacharya/dp/9353164907',
        ),
        BookItem(
          title: 'Engineering Physics — Sujay Kumar Bhattacharya (McGraw Hill), Chapter 5 (Laser)',
          storeUrl: 'https://www.amazon.in/Engineering-Physics-Sujay-Kumar-Bhattacharya/dp/9353164907',
        ),
      ],
      labAssignments: const [
        'Determine the radius of curvature of a plano-convex lens via Newton’s rings.',
        'Determine wavelengths of a light source using a diffraction grating.',
      ],
    ),
    ModuleItem(
      number: 4,
      title: 'Introduction to Electromagnetic Theory',
      lectureHours: 6,
      sections: [
        ModuleSection(
          heading: 'Maxwell’s Equations (Foundations)',
          bullets: [
            'Magnetic flux; Faraday’s law; electromotive force (EMF)',
            'Integral form of Faraday’s law; displacement current',
            'Ampère’s circuital law; modified Ampère’s law; continuity of current',
            'Synthesis into Maxwell’s equations',
          ],
        ),
      ],
      academiaLinks: const [
        LinkItem(
          label: 'International Academia (MIT Physics)',
          url: 'https://catalog.mit.edu/subjects/8/',
          kind: LinkKind.academia,
        ),
        LinkItem(
          label: 'AICTE Model Curriculum (ECE)',
          url: 'https://www.aicteindia.org/sites/default/files/Model_Curriculum/Final_ECE.pdf',
          kind: LinkKind.academia,
        ),
      ],
      industryLinks: const [],
      textbooks: const [
        BookItem(
          title: 'Engineering Physics — Sujay Kumar Bhattacharya (McGraw Hill), Chapter 7',
          storeUrl: 'https://www.amazon.in/Engineering-Physics-Sujay-Kumar-Bhattacharya/dp/9353164907',
        ),
      ],
      labAssignments: const [
        'Determine electron charge-to-mass ratio (e/m).',
        'Determine the Hall coefficient.',
        'Convert vibration to voltage using piezoelectric materials.',
      ],
    ),
    ModuleItem(
      number: 5,
      title: 'Quantum Mechanics',
      lectureHours: 7,
      sections: [
        ModuleSection(
          heading: 'Quantum Foundations',
          bullets: [
            'Wave function: physical significance; normalization & orthogonality',
            'Operators; postulates of quantum mechanics',
            'Time-dependent & time-independent Schrödinger equations; applications',
            'Quantum harmonic oscillator; hydrogen atom (overview)',
          ],
        ),
      ],
      academiaLinks: const [
        LinkItem(
          label: 'International Academia (MIT Physics)',
          url: 'https://catalog.mit.edu/subjects/8/',
          kind: LinkKind.academia,
        ),
        LinkItem(
          label: 'AICTE Model Curriculum (ECE)',
          url: 'https://www.aicteindia.org/sites/default/files/Model_Curriculum/Final_ECE.pdf',
          kind: LinkKind.academia,
        ),
      ],
      industryLinks: const [
        LinkItem(
          label: 'Industry Mapping: MATLAB',
          url: 'https://www.mathworks.com/products/matlab.html',
          kind: LinkKind.industry,
        ),
      ],
      textbooks: const [
        BookItem(
          title: 'Engineering Physics — Sujay Kumar Bhattacharya (McGraw Hill), Chapter 10',
          storeUrl: 'https://www.amazon.in/Engineering-Physics-Sujay-Kumar-Bhattacharya/dp/9353164907',
        ),
      ],
      labAssignments: const [
        'Determine Planck’s constant via the photoelectric effect.',
        'Measure excitation potential using the Franck–Hertz experiment.',
        'Determine Planck’s constant using LEDs.',
        'Estimate band gap of a semiconductor via temperature-dependent resistivity (four-probe).',
        'Study characteristics of a solar cell.',
      ],
    ),
    ModuleItem(
      number: 6,
      title: 'Statistical Mechanics',
      lectureHours: 6,
      sections: [
        ModuleSection(
          heading: 'Statistics & Ensembles',
          bullets: [
            'Phase space; energy levels & states; macrostate vs microstate',
            'Thermodynamic probability & entropy; equilibrium macrostate',
            'MB, BE & FD statistics; classical statistics as a limit of quantum',
            'Density of states; Fermi distributions at 0 K and T > 0',
            'Planck’s law from BE statistics; comparison of MB/BE/FD distributions',
          ],
        ),
      ],
      academiaLinks: const [
        LinkItem(
          label: 'International Academia (MIT Physics)',
          url: 'https://catalog.mit.edu/subjects/8/',
          kind: LinkKind.academia,
        ),
        LinkItem(
          label: 'AICTE Model Curriculum (ECE)',
          url: 'https://www.aicteindia.org/sites/default/files/Model_Curriculum/Final_ECE.pdf',
          kind: LinkKind.academia,
        ),
      ],
      industryLinks: const [],
      textbooks: const [
        BookItem(
          title: 'Engineering Physics — Sujay Kumar Bhattacharya (McGraw Hill), Chapter 11',
          storeUrl: 'https://www.amazon.in/Engineering-Physics-Sujay-Kumar-Bhattacharya/dp/9353164907',
        ),
      ],
      labAssignments: const [],
    ),
  ];

  // ----------------------- ADDITIONAL RESOURCES -----------------------
  static const List<LinkItem> _coursera = [
    LinkItem(
      label: 'Electrodynamics: Electric and Magnetic Fields',
      url: 'https://www.coursera.org/learn/electrodynamics-electric-magnetic-fields',
      kind: LinkKind.course,
    ),
    LinkItem(
      label: 'Electrodynamics: In-depth Solutions for Maxwell’s Equations',
      url: 'https://www.coursera.org/learn/electrodynamics-solutions-maxwells-equations',
      kind: LinkKind.course,
    ),
    LinkItem(
      label: 'Quantum Mechanics for Engineers (Specialization)',
      url: 'https://www.coursera.org/specializations/quantum-mechanics-for-engineers',
      kind: LinkKind.course,
    ),
    LinkItem(
      label: 'Mechanics: Motion, Forces, Energy and Gravity, from Particles to Planets',
      url: 'https://www.coursera.org/learn/mechanics-particles-planets',
      kind: LinkKind.course,
    ),
    LinkItem(
      label: 'Quantum Mechanics',
      url: 'https://www.coursera.org/learn/quantum-mechanics',
      kind: LinkKind.course,
    ),
    LinkItem(
      label: 'Vector Calculus for Engineers',
      url: 'https://www.coursera.org/learn/vector-calculus-engineers',
      kind: LinkKind.course,
    ),
    LinkItem(
      label: 'Physics of Oscillators and Waves',
      url: 'https://www.coursera.org/learn/oscillators-waves',
      kind: LinkKind.course,
    ),
    LinkItem(
      label: 'Exploring Quantum Physics',
      url: 'https://www.coursera.org/learn/quantum-physics',
      kind: LinkKind.course,
    ),
  ];

  static const List<BookItem> _extraBooks = [
    BookItem(
      title: 'Engineering Physics — Sujay Kumar Bhattacharya (McGraw Hill)',
      storeUrl: 'https://www.amazon.in/Engineering-Physics-Sujay-Kumar-Bhattacharya/dp/9353164907',
    ),
    BookItem(
      title: 'Schaum’s Outline: Theoretical Mechanics — Murray R. Spiegel (SI/Metric)',
      storeUrl: 'https://www.amazon.co.uk/Problems-Theoretical-Mechanics-Schaums-Outline/dp/0070843570',
    ),
    BookItem(
      title: 'Advanced Acoustics — D. P. Raychaudhuri (The New Book Stall), 9th ed.',
      storeUrl: 'https://www.amazon.in/Advanced-Acoustics-Dr-D-RayChaudhuri/dp/B01N0Y6FBG',
    ),
    BookItem(
      title: 'A Textbook on Optics — B. Ghosh & K. G. Majumder (Sreedhar), 5th ed.',
      storeUrl: 'https://www.flipkart.com/text-book-light-b-ghosh-k-g-mazumdar/p/itm8bfccb505fe3f',
    ),
    BookItem(
      title: 'Introduction to Electrodynamics — David J. Griffiths, 3rd ed.',
      storeUrl: 'https://www.amazon.com/Introduction-Electrodynamics-3rd-David-Griffiths/dp/013805326X',
    ),
    BookItem(
      title: 'Concepts of Modern Physics — Arthur Beiser, 6th ed.',
      storeUrl: 'https://www.amazon.com/Concepts-Modern-Physics-2002/dp/B000MT7Z4S',
    ),
  ];

  bool _expandCoursera = false;
  bool _expandBooks = false;

  // ----------------------- LIFECYCLE -----------------------
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ----------------------- SEARCH -----------------------
  List<ModuleItem> get _filteredModules {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return _modules;
    bool matches(ModuleItem m) {
      if (m.title.toLowerCase().contains(q)) return true;
      for (final s in m.sections) {
        if ((s.heading ?? '').toLowerCase().contains(q)) return true;
        if (s.bullets.any((b) => b.toLowerCase().contains(q))) return true;
      }
      if (m.labAssignments.any((b) => b.toLowerCase().contains(q))) return true;
      if (m.textbooks.any((b) => b.title.toLowerCase().contains(q))) return true;
      return false;
    }

    return _modules.where(matches).toList();
  }

  // ----------------------- UI -----------------------
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theory'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Search bar
          Card(
            elevation: 0,
            color: cs.surfaceContainerHighest,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  Icon(Icons.search, color: cs.onSurfaceVariant),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search modules, topics, or labs',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.search,
                      onChanged: (v) => setState(() => _query = v),
                    ),
                  ),
                  if (_query.isNotEmpty)
                    IconButton(
                      tooltip: 'Clear',
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _query = '');
                      },
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Main heading: Topics (Modules)
          Text(
            'Topics',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          if (_filteredModules.isEmpty)
            const _EmptyCard(text: 'No modules match your search.')
          else
            ..._filteredModules.map((m) => _ModuleCard(
                  module: m,
                  onOpenLink: _openUrl,
                  onCopyLink: _copyLink,
                  onOpenModulePdf: _openModulePdf, // NEW
                )),

          const SizedBox(height: 20),

          // Secondary heading: Additional Resources
          Text(
            'Additional Resources',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                ),
          ),
          const SizedBox(height: 8),

          // Coursera (expandable)
          _ExpandableCard(
            title: 'Coursera Courses',
            expanded: _expandCoursera,
            onChanged: (v) => setState(() => _expandCoursera = v),
            child: Column(
              children: _coursera
                  .map(
                    (r) => _LinkTile(
                      leadingIcon: Icons.school_outlined,
                      title: r.label,
                      url: r.url,
                      onOpen: () => _openUrl(r.url),
                      onCopy: () => _copyLink(r.url),
                    ),
                  )
                  .toList(),
            ),
          ),

          const SizedBox(height: 12),

          // Text/Reference Books (expandable)
          _ExpandableCard(
            title: 'Text & Reference Books',
            expanded: _expandBooks,
            onChanged: (v) => setState(() => _expandBooks = v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Subheading(text: 'Books'),
                const SizedBox(height: 6),
                ..._extraBooks.map(
                  (b) => _LinkTile(
                    leadingIcon: Icons.menu_book_outlined,
                    title: b.title,
                    url: b.storeUrl,
                    onOpen: () => _openUrl(b.storeUrl),
                    onCopy: () => _copyLink(b.storeUrl),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ----------------------- ACTIONS -----------------------
  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open link'), behavior: SnackBarBehavior.floating),
      );
    }
  }

  Future<void> _copyLink(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Link copied to clipboard'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Opens the module's PDF from bundled assets using the platform's default PDF app.
  /// Expects assets at: lib/assets/pdfs/Module{N}.pdf  (declared in pubspec.yaml)
  Future<void> _openModulePdf(int moduleNumber) async {
  if (kIsWeb) {
    // For assets declared as `lib/assets/pdfs/` in pubspec.yaml
    final url = 'assets/lib/assets/pdfs/Module$moduleNumber.pdf';
    final ok = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.platformDefault, // opens a new tab with the browser PDF viewer
    );
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open PDF in browser')),
      );
    }
    return;
  }

  // Mobile/desktop path used by rootBundle:
  const base = 'lib/assets/pdfs';
  final assetPath = '$base/Module$moduleNumber.pdf';
  try {
    final data = await rootBundle.load(assetPath);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/Module$moduleNumber.pdf');
    await file.writeAsBytes(
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      flush: true,
    );
    final result = await OpenFilex.open(file.path);
    if (result.type != ResultType.done && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open PDF (${result.message}).')),
      );
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening PDF: $e')),
      );
    }
  }
}
}

// ======================= MODELS =======================

class ModuleItem {
  final int number;
  final String title;
  final int? lectureHours;
  final List<ModuleSection> sections;
  final List<LinkItem> academiaLinks;
  final List<LinkItem> industryLinks;
  final List<BookItem> textbooks;
  final List<String> labAssignments;

  ModuleItem({
    required this.number,
    required this.title,
    required this.lectureHours,
    required this.sections,
    required this.academiaLinks,
    required this.industryLinks,
    required this.textbooks,
    required this.labAssignments,
  });
}

class ModuleSection {
  final String? heading;
  final List<String> bullets;
  const ModuleSection({this.heading, required this.bullets});
}

enum LinkKind { course, academia, industry }

class LinkItem {
  final String label;
  final String url;
  final LinkKind kind;
  const LinkItem({required this.label, required this.url, required this.kind});
}

class BookItem {
  final String title;
  final String storeUrl;
  const BookItem({required this.title, required this.storeUrl});
}

// ======================= WIDGETS =======================

class _ModuleCard extends StatelessWidget {
  final ModuleItem module;
  final Future<void> Function(String url) onOpenLink;
  final Future<void> Function(String url) onCopyLink;
  final Future<void> Function(int moduleNumber) onOpenModulePdf; // NEW

  const _ModuleCard({
    required this.module,
    required this.onOpenLink,
    required this.onCopyLink,
    required this.onOpenModulePdf, // NEW
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: cs.surfaceContainerLowest,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  'Module ${module.number} — ${module.title}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              if (module.lectureHours != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: cs.secondaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${module.lectureHours} hrs',
                    style: TextStyle(color: cs.onSecondaryContainer, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
          children: [
            // Sub-topics
            if (module.sections.isNotEmpty) ...[
              const _Subheading(text: 'Sub-topics'),
              const SizedBox(height: 8),
              ...module.sections.map((s) => _BulletBlock(heading: s.heading, bullets: s.bullets)),
              const SizedBox(height: 12),
            ],

            const _Subheading(text: 'Study Material'),
            const SizedBox(height: 6),
            _LinkTile(
    leadingIcon: Icons.picture_as_pdf_outlined,
    title: 'Module ${module.number} Study Material (PDF)',
    url: 'lib/assets/pdfs/Module${module.number}.pdf', 
    onOpen: () => onOpenModulePdf(module.number),
    onCopy: () => Clipboard.setData(
      ClipboardData(text: 'lib/assets/pdfs/Module${module.number}.pdf'),
  ),
),
            const SizedBox(height: 12),

            // Academia & Industry mapping (links)
            if (module.academiaLinks.isNotEmpty || module.industryLinks.isNotEmpty) ...[
              const _Subheading(text: 'Mapping with Industry & International Academia'),
              const SizedBox(height: 6),
              ...module.academiaLinks.map(
                (l) => _LinkTile(
                  leadingIcon: Icons.public_outlined,
                  title: l.label,
                  url: l.url,
                  onOpen: () => onOpenLink(l.url),
                  onCopy: () => onCopyLink(l.url),
                ),
              ),
              ...module.industryLinks.map(
                (l) => _LinkTile(
                  leadingIcon: Icons.memory_outlined,
                  title: l.label,
                  url: l.url,
                  onOpen: () => onOpenLink(l.url),
                  onCopy: () => onCopyLink(l.url),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Textbook mapping
            if (module.textbooks.isNotEmpty) ...[
              const _Subheading(text: 'Text Book Mapping'),
              const SizedBox(height: 6),
              ...module.textbooks.map(
                (b) => _LinkTile(
                  leadingIcon: Icons.menu_book_outlined,
                  title: b.title,
                  url: b.storeUrl,
                  onOpen: () => onOpenLink(b.storeUrl),
                  onCopy: () => onCopyLink(b.storeUrl),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Lab assignments
            if (module.labAssignments.isNotEmpty) ...[
              const _Subheading(text: 'Corresponding Lab Assignment'),
              const SizedBox(height: 6),
              _BulletedList(items: module.labAssignments),
              const SizedBox(height: 6),
            ],
          ],
        ),
      ),
    );
  }
}

class _LinkTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String url;
  final VoidCallback onOpen;
  final VoidCallback onCopy;

  const _LinkTile({
    required this.leadingIcon,
    required this.title,
    required this.url,
    required this.onOpen,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      leading: Icon(leadingIcon, color: cs.primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(url, style: TextStyle(color: cs.onSurfaceVariant), overflow: TextOverflow.ellipsis),
      trailing: Wrap(
        spacing: 6,
        children: [
          IconButton(
            tooltip: 'Open',
            icon: const Icon(Icons.open_in_new),
            onPressed: onOpen,
          ),
          IconButton(
            tooltip: 'Copy',
            icon: const Icon(Icons.copy),
            onPressed: onCopy,
          ),
        ],
      ),
      onTap: onOpen,
      onLongPress: onCopy,
    );
  }
}

class _ExpandableCard extends StatelessWidget {
  final String title;
  final bool expanded;
  final ValueChanged<bool> onChanged;
  final Widget child;

  const _ExpandableCard({
    required this.title,
    required this.expanded,
    required this.onChanged,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: cs.surfaceContainerLowest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: expanded,
          onExpansionChanged: onChanged,
          tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          children: [child],
        ),
      ),
    );
  }
}

class _Subheading extends StatelessWidget {
  final String text;
  const _Subheading({required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: cs.onSurfaceVariant,
          ),
    );
  }
}

class _BulletBlock extends StatelessWidget {
  final String? heading;
  final List<String> bullets;
  const _BulletBlock({this.heading, required this.bullets});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (heading != null) ...[
            Text(heading!, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
          ],
          _BulletedList(items: bullets),
        ],
      ),
    );
  }
}

class _BulletedList extends StatelessWidget {
  final List<String> items;
  const _BulletedList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (t) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  '),
                  Expanded(child: Text(t)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  final String text;
  const _EmptyCard({required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: cs.surfaceContainerLowest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('No modules match your search.'),
      ),
    );
  }
}
