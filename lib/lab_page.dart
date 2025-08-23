import 'package:flutter/material.dart';

class LabPage extends StatefulWidget {
  const LabPage({super.key});

  @override
  State<LabPage> createState() => _LabPageState();
}

class _LabPageState extends State<LabPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  // ----------------------- LAB EXPERIMENTS DATA -----------------------
  static final List<LabExperiment> _labExperiments = [
    LabExperiment(
      number: 1,
      title: 'Rigidity Modulus Determination',
      module: 'Mechanics',
      pageRange: '1-3',
      objective: 'Determine the rigidity modulus of the material of a wire using dynamic method',
      equipment: [
        'Torsional pendulum apparatus',
        'Stopwatch',
        'Meter scale',
        'Vernier caliper',
        'Test wire',
        'Weights'
      ],
      procedure: [
        'Measure the diameter and length of the test wire',
        'Set up the torsional pendulum with the wire',
        'Add known weights and measure time period for oscillations',
        'Calculate rigidity modulus using the formula: η = (π r⁴ P) / (2 l T²)',
        'Repeat with static method for comparison'
      ],
      theory: 'Rigidity modulus measures the resistance of a material to shear deformation. The dynamic method uses torsional oscillations while static method uses direct torque application.',
      precautions: [
        'Ensure wire is free from kinks and twists',
        'Take multiple readings for accuracy',
        'Maintain constant temperature',
        'Handle weights carefully to avoid accidents'
      ],
    ),
    LabExperiment(
      number: 2,
      title: 'Acceleration Due to Gravity',
      module: 'Mechanics',
      pageRange: '4-6',
      objective: 'Determine acceleration due to gravity using bar pendulum',
      equipment: [
        'Bar pendulum',
        'Stopwatch',
        'Meter scale',
        'Vernier caliper',
        'Support stand'
      ],
      procedure: [
        'Measure the length of the pendulum from pivot to center of mass',
        'Displace the pendulum by small angle and release',
        'Measure time for 20 oscillations',
        'Calculate g using formula: g = (4π²L) / T²',
        'Repeat measurements for accuracy'
      ],
      theory: 'A simple pendulum follows SHM for small angles. The period depends on length and gravity, allowing g calculation.',
      precautions: [
        'Keep amplitude small (<10°)',
        'Ensure pendulum swings in plane',
        'Take multiple sets of readings',
        'Account for air resistance'
      ],
    ),
    LabExperiment(
      number: 3,
      title: 'Young\'s Modulus Determination',
      module: 'Mechanics',
      pageRange: '7-9',
      objective: 'Determine Young\'s modulus of elasticity using Searle\'s apparatus',
      equipment: [
        'Searle\'s apparatus',
        'Vernier caliper',
        'Screw gauge',
        'Test wire',
        'Weights',
        'Spirit level'
      ],
      procedure: [
        'Measure diameter and length of test wire',
        'Set up Searle\'s apparatus with wire',
        'Apply incremental loads and measure extensions',
        'Plot stress-strain curve',
        'Calculate Young\'s modulus from slope: Y = (stress) / (strain)'
      ],
      theory: 'Young\'s modulus is the ratio of stress to strain within elastic limit. It measures material\'s stiffness.',
      precautions: [
        'Ensure wire is straight and uniform',
        'Apply loads gradually',
        'Take readings during loading and unloading',
        'Avoid exceeding elastic limit'
      ],
    ),
    LabExperiment(
      number: 4,
      title: 'Newton\'s Rings Experiment',
      module: 'Optics',
      pageRange: '10-12',
      objective: 'Determine radius of curvature of plano-convex lens using Newton\'s rings',
      equipment: [
        'Newton\'s rings apparatus',
        'Sodium vapor lamp',
        'Traveling microscope',
        'Plano-convex lens',
        'Optical flat glass plate'
      ],
      procedure: [
        'Set up Newton\'s rings apparatus with sodium light',
        'Focus microscope on ring pattern',
        'Measure diameters of multiple rings',
        'Calculate radius of curvature using formula: R = (Dₙ² - Dₘ²) / (4λ(n - m))',
        'Verify with different ring orders'
      ],
      theory: 'Newton\'s rings are formed due to interference between light reflected from lens and glass plate surfaces.',
      precautions: [
        'Ensure lens and plate are clean',
        'Use monochromatic light source',
        'Align apparatus properly',
        'Take multiple measurements'
      ],
    ),
    LabExperiment(
      number: 5,
      title: 'Diffraction Grating Experiment',
      module: 'Optics',
      pageRange: '13-15',
      objective: 'Determine wavelength of light using diffraction grating',
      equipment: [
        'Diffraction grating',
        'Spectrometer',
        'Sodium vapor lamp',
        'Reading telescope',
        'Scale'
      ],
      procedure: [
        'Set up spectrometer with sodium light',
        'Adjust grating for normal incidence',
        'Measure angles for first and second order spectra',
        'Calculate wavelength using formula: λ = (d sinθ) / n',
        'Compare with standard value'
      ],
      theory: 'Diffraction grating splits light into spectrum. Wavelength is calculated from diffraction angles.',
      precautions: [
        'Use monochromatic light',
        'Ensure proper alignment',
        'Take readings for both sides',
        'Account for instrumental errors'
      ],
    ),
  ];

  // ----------------------- VIRTUAL EXPERIMENTS DATA -----------------------
  static final List<VirtualExperiment> _virtualExperiments = [
    VirtualExperiment(
      title: 'Virtual Pendulum Simulation',
      module: 'Oscillations',
      platform: 'PhET Interactive Simulations',
      url: 'https://phet.colorado.edu/sims/html/pendulum-lab/latest/pendulum-lab_en.html',
      description: 'Interactive simulation to study pendulum motion, period, and energy conservation',
      features: [
        'Adjust pendulum length and mass',
        'Change gravity and damping',
        'Plot position vs time graphs',
        'Analyze energy transformations'
      ],
      learningOutcomes: [
        'Understand SHM in pendulums',
        'Explore factors affecting period',
        'Study energy conservation',
        'Analyze damping effects'
      ],
    ),
    VirtualExperiment(
      title: 'Wave Interference Simulator',
      module: 'Optics',
      platform: 'PhET Interactive Simulations',
      url: 'https://phet.colorado.edu/sims/html/wave-interference/latest/wave-interference_en.html',
      description: 'Simulate wave interference patterns with adjustable parameters',
      features: [
        'Control wavelength and amplitude',
        'Adjust slit separation',
        'View interference patterns',
        'Measure fringe spacing'
      ],
      learningOutcomes: [
        'Understand interference principles',
        'Explore diffraction patterns',
        'Study wave superposition',
        'Analyze fringe formation'
      ],
    ),
    VirtualExperiment(
      title: 'Circuit Construction Kit',
      module: 'Electromagnetic Theory',
      platform: 'PhET Interactive Simulations',
      url: 'https://phet.colorado.edu/sims/html/circuit-construction-kit-dc/latest/circuit-construction-kit-dc_en.html',
      description: 'Build and analyze electrical circuits virtually',
      features: [
        'Drag and drop circuit components',
        'Measure voltage and current',
        'Study Ohm\'s law and Kirchhoff\'s laws',
        'Analyze series and parallel circuits'
      ],
      learningOutcomes: [
        'Understand circuit principles',
        'Apply Kirchhoff\'s laws',
        'Study electrical measurements',
        'Analyze circuit behavior'
      ],
    ),
    VirtualExperiment(
      title: 'Quantum Tunneling Demo',
      module: 'Quantum Mechanics',
      platform: 'Online Physics Simulations',
      url: 'https://www.falstad.com/quantum/',
      description: 'Visualize quantum tunneling through potential barriers',
      features: [
        'Adjust barrier height and width',
        'Control particle energy',
        'View probability distributions',
        'Study transmission coefficients'
      ],
      learningOutcomes: [
        'Understand quantum tunneling',
        'Explore wave-particle duality',
        'Study probability in quantum mechanics',
        'Analyze barrier penetration'
      ],
    ),
    VirtualExperiment(
      title: 'Molecular Dynamics Simulation',
      module: 'Statistical Mechanics',
      platform: 'PhET Interactive Simulations',
      url: 'https://phet.colorado.edu/sims/html/states-of-matter/latest/states-of-matter_en.html',
      description: 'Explore states of matter and phase transitions',
      features: [
        'Control temperature and pressure',
        'Observe molecular motion',
        'Study phase changes',
        'Analyze particle interactions'
      ],
      learningOutcomes: [
        'Understand molecular behavior',
        'Explore phase transitions',
        'Study thermal equilibrium',
        'Analyze kinetic theory'
      ],
    ),
  ];

  bool _expandVirtual = false;

  // ----------------------- LIFECYCLE -----------------------
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ----------------------- SEARCH -----------------------
  List<LabExperiment> get _filteredLabExperiments {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return _labExperiments;
    bool matches(LabExperiment exp) {
      if (exp.title.toLowerCase().contains(q)) return true;
      if (exp.module.toLowerCase().contains(q)) return true;
      if (exp.objective.toLowerCase().contains(q)) return true;
      if (exp.equipment.any((e) => e.toLowerCase().contains(q))) return true;
      if (exp.pageRange.toLowerCase().contains(q)) return true;
      return false;
    }
    return _labExperiments.where(matches).toList();
  }

  List<VirtualExperiment> get _filteredVirtualExperiments {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return _virtualExperiments;
    bool matches(VirtualExperiment exp) {
      if (exp.title.toLowerCase().contains(q)) return true;
      if (exp.module.toLowerCase().contains(q)) return true;
      if (exp.description.toLowerCase().contains(q)) return true;
      if (exp.features.any((f) => f.toLowerCase().contains(q))) return true;
      return false;
    }
    return _virtualExperiments.where(matches).toList();
  }

  // ----------------------- UI -----------------------
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Experiments'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Search bar
          Card(
            elevation: 2,
            color: cs.surfaceContainerHighest,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.search, color: cs.onSurfaceVariant, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search experiments, modules, or equipment',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: cs.onSurfaceVariant.withOpacity(0.7)),
                      ),
                      textInputAction: TextInputAction.search,
                      onChanged: (v) => setState(() => _query = v),
                    ),
                  ),
                  if (_query.isNotEmpty)
                    IconButton(
                      tooltip: 'Clear',
                      icon: Icon(Icons.close, size: 20),
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

          // Main heading: Lab Experiments
          Row(
            children: [
              Icon(Icons.science_outlined, color: cs.primary, size: 24),
              const SizedBox(width: 8),
              Text(
                'Lab Experiments',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          if (_filteredLabExperiments.isEmpty)
            const _EmptyCard(text: 'No lab experiments match your search.')
          else
            ..._filteredLabExperiments.map((exp) => _LabExperimentCard(experiment: exp)),

          const SizedBox(height: 20),

          // Secondary heading: Virtual Experiments
          Row(
            children: [
              Icon(Icons.computer_outlined, color: cs.tertiary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Virtual Experiments',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Virtual Experiments (expandable)
          _ExpandableCard(
            title: 'Virtual Lab Simulations',
            expanded: _expandVirtual,
            onChanged: (v) => setState(() => _expandVirtual = v),
            child: Column(
              children: _filteredVirtualExperiments
                  .map((exp) => _VirtualExperimentCard(experiment: exp))
                  .toList(),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ======================= MODELS =======================

class LabExperiment {
  final int number;
  final String title;
  final String module;
  final String pageRange;
  final String objective;
  final List<String> equipment;
  final List<String> procedure;
  final String theory;
  final List<String> precautions;

  const LabExperiment({
    required this.number,
    required this.title,
    required this.module,
    required this.pageRange,
    required this.objective,
    required this.equipment,
    required this.procedure,
    required this.theory,
    required this.precautions,
  });
}

class VirtualExperiment {
  final String title;
  final String module;
  final String platform;
  final String url;
  final String description;
  final List<String> features;
  final List<String> learningOutcomes;

  const VirtualExperiment({
    required this.title,
    required this.module,
    required this.platform,
    required this.url,
    required this.description,
    required this.features,
    required this.learningOutcomes,
  });
}

// ======================= WIDGETS =======================

class _LabExperimentCard extends StatelessWidget {
  final LabExperiment experiment;

  const _LabExperimentCard({required this.experiment});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      elevation: 1,
      color: cs.surfaceContainerLowest,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  'Exp ${experiment.number} — ${experiment.title}',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: cs.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Pages: ${experiment.pageRange ?? 'N/A'}',
                  style: TextStyle(color: cs.onSecondaryContainer, fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Module: ${experiment.module}',
              style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13),
            ),
          ),
          children: [
            // Objective
            const _Subheading(text: 'Objective'),
            const SizedBox(height: 6),
            Text(experiment.objective),
            const SizedBox(height: 12),

            // Equipment
            const _Subheading(text: 'Equipment Required'),
            const SizedBox(height: 6),
            _BulletedList(items: experiment.equipment),
            const SizedBox(height: 12),

            // Procedure
            const _Subheading(text: 'Procedure'),
            const SizedBox(height: 6),
            _NumberedList(items: experiment.procedure),
            const SizedBox(height: 12),

            // Theory
            const _Subheading(text: 'Theory'),
            const SizedBox(height: 6),
            Text(experiment.theory),
            const SizedBox(height: 12),

            // Precautions
            const _Subheading(text: 'Precautions'),
            const SizedBox(height: 6),
            _BulletedList(items: experiment.precautions),
          ],
        ),
      ),
    );
  }
}

class _VirtualExperimentCard extends StatelessWidget {
  final VirtualExperiment experiment;

  const _VirtualExperimentCard({required this.experiment});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      elevation: 1,
      color: cs.surfaceContainerLowest,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    experiment.title,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: cs.tertiaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    experiment.module,
                    style: TextStyle(color: cs.onTertiaryContainer, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Platform: ${experiment.platform}',
              style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13),
            ),
            const SizedBox(height: 8),
            Text(
              experiment.description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),

            // Features
            const _Subheading(text: 'Features'),
            const SizedBox(height: 6),
            _BulletedList(items: experiment.features),
            const SizedBox(height: 12),

            // Learning Outcomes
            const _Subheading(text: 'Learning Outcomes'),
            const SizedBox(height: 6),
            _BulletedList(items: experiment.learningOutcomes),
            const SizedBox(height: 12),

            // Launch Button
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  // TODO: Implement URL launch
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Opening ${experiment.title}...'),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.launch, size: 18),
                label: const Text('Launch Simulation'),
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
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
      elevation: 1,
      color: cs.surfaceContainerLowest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: expanded,
          onExpansionChanged: onChanged,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
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

class _NumberedList extends StatelessWidget {
  final List<String> items;
  const _NumberedList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .asMap()
          .entries
          .map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${entry.key + 1}.  '),
                  Expanded(child: Text(entry.value)),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(text),
      ),
    );
  }
}