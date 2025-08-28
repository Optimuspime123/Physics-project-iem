
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_latex/easy_latex.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

@visibleForTesting
List<LabExperiment> filterLabExperiments(
    List<LabExperiment> experiments, String query) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return experiments;
  return experiments
      .where((exp) =>
          exp.title.toLowerCase().contains(q) ||
          exp.objective.toLowerCase().contains(q))
      .toList();
}

@visibleForTesting
List<VirtualExperiment> filterVirtualExperiments(
    List<VirtualExperiment> experiments, String query) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return experiments;
  return experiments
      .where((exp) =>
          exp.title.toLowerCase().contains(q) ||
          exp.module.toLowerCase().contains(q) ||
          exp.description.toLowerCase().contains(q) ||
          exp.features.any((f) => f.toLowerCase().contains(q)))
      .toList();
}

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
      title: 'Carey Foster Bridge Experiment',
      pageRange: '01-06',
      objective:
          'Determine the resistance per unit length of the bridge wire and hence the value of a low unknown resistance.',
      theory: r'''
The Carey Foster bridge is a modified Wheatstone bridge for comparing very small resistances.
At balance:
$$\frac{R_1}{R_2}=\frac{R_3}{R_4}$$
Shifting the balance point along the uniform bridge wire relates the difference in resistances to the change in balance length and the wire resistance per unit length.
''',
    ),
    LabExperiment(
      number: 2,
      title: 'Newton’s Ring Experiment',
      pageRange: '07-12',
      objective:
          'Study interference in a thin air film and determine the radius of curvature of a plano–convex lens using ring diameters.',
      theory: r'''
For reflection at the air–glass interface, the conditions are:
Bright fringes:
$$2\mu t=\left(n+\frac{1}{2}\right)\lambda$$
Dark fringes:
$$2\mu t=n\lambda$$
Using ring diameters, the lens radius of curvature is
$$R=\frac{D_{n+m}^{2}-D_{n}^{2}}{4m\lambda}$$
''',
    ),
    LabExperiment(
      number: 3,
      title: 'Determination of Modulus of Rigidity by Static Method',
      pageRange: '13-17',
      objective:
          'Determine the rigidity (shear) modulus η of a wire/rod using the static torsion method.',
      theory: r'''
For a cylindrical rod of length \(l\) and radius \(r\), torque–twist is:
$$\tau=C\theta$$
and
$$C=\frac{\pi \eta r^{4}}{2l}$$
From measured torque \( \tau \) and twist \( \theta \), the rigidity modulus follows as
$$\eta=\frac{2l\,\tau}{\pi r^{4}\theta}$$
''',
    ),
    LabExperiment(
      number: 4,
      title: 'Laser Diffraction Experiment',
      pageRange: '18-21',
      objective: 'Determine the wavelength of the given laser using diffraction.',
      theory: r'''
For a grating (or equivalent spacing \(d\)), the diffraction condition is
$$d\sin\theta=m\lambda$$
Measuring \( \theta \) for order \( m \) yields the wavelength:
\(\lambda=\frac{d\sin\theta}{m}\)
''',
    ),
    LabExperiment(
      number: 5,
      title:
          'Determination of the Bandgap of a Semiconductor by Four-Probe Method',
      pageRange: '22-27',
      objective:
          'Determine the bandgap Eg by measuring resistivity vs temperature using the four-probe setup.',
      theory: r'''
For intrinsic conduction:
$$\rho=A\exp\left(\frac{E_g}{2kT}\right)$$
Thus a plot of \(\ln\rho\) vs \(1/T\) is linear with slope \(\frac{E_g}{2k}\).
''',
    ),
    LabExperiment(
      number: 6,
      title: 'To Study the Characteristics of Solar Cell',
      pageRange: '28-33',
      objective:
          'Obtain I–V characteristics of a solar cell; study power vs load, area dependence, and spectral response.',
      theory: r'''
A p–n junction under illumination generates photocurrent. Output power:
$$P=VI$$
Maximum power occurs near the knee of the I–V curve; response depends on spectrum and irradiance.
''',
    ),
    LabExperiment(
      number: 7,
      title: 'Determination of Young’s Modulus',
      pageRange: '34-39',
      objective:
          'Determine Young’s modulus of an elastic bar by flexure between knife-edges.',
      theory: r'''
For a simply supported bar (span \(L\)) with central load \(mg\), breadth \(b\), depth \(d\), and midpoint depression \(l\):
$$Y=\frac{4mgL^{3}}{bd^{3}l}$$
(Within elastic, small-deflection limits.)
''',
    ),
    LabExperiment(
      number: 8,
      title: 'Franck–Hertz Experiment',
      pageRange: '40-43',
      objective:
          'Verify the quantized nature of atomic energy levels via inelastic electron–atom collisions.',
      theory: r'''
Current vs accelerating voltage shows periodic minima/maxima corresponding to excitation quanta:
$$\Delta E=h\nu$$
''',
    ),
    LabExperiment(
      number: 9,
      title: 'Determination of Modulus of Rigidity by Dynamic Method',
      pageRange: '44-48',
      objective:
          'Determine the rigidity modulus of the suspension wire using torsional oscillations.',
      theory: r'''
For torsional oscillations:
$$T=2\pi\sqrt{\frac{I}{C}}$$
and
$$C=\frac{\pi \eta r^{4}}{2l}$$
Using periods with and without a known inertia yields \(\eta\) from the change in \(T^{2}\).
''',
    ),
    LabExperiment(
      number: 10,
      title: 'Laser-Based Free-Space Communication Experiment',
      pageRange: '49-57',
      objective:
          'Demonstrate an analog free-space optical link; study alignment, range, and fidelity.',
      theory: r'''
A current-modulated laser transmits intensity variations; a photodiode and amplifier recover the signal. Link budget depends on divergence, aperture, and ambient noise.
''',
    ),
    LabExperiment(
      number: 11,
      title: 'Particle Accelerator Experiment',
      pageRange: '58-63',
      objective:
          'Explore basic accelerator concepts (acceleration and focusing) on the training setup.',
      theory: r'''
Charged particles gain energy from RF electric fields and are guided/focused by magnetic elements; diagnostics infer energy and beam analogs.
''',
    ),
    LabExperiment(
      number: 12,
      title: 'Hall Effect Experiment',
      pageRange: '64-73',
      objective:
          'Measure Hall voltage and determine the Hall coefficient and carrier type/density.',
      theory: r'''
With current \(I\), magnetic field \(B\), and sample thickness \(t\):
$$V_H=\frac{R_H I B}{t}$$
$$R_H=\frac{1}{ne}$$
Sign of \(V_H\) identifies the majority carrier; magnitude gives \(n\).
''',
    ),
    LabExperiment(
      number: 13,
      title: 'Determination of Electronic Charge by its Mass (e/m)',
      pageRange: '74-78',
      objective:
          'Determine e/m of the electron by magnetic deflection (Helmholtz coils).',
      theory: r'''
For electrons accelerated by potential \(V\), bent by field \(B\) in a circle of radius \(r\):
$$\frac{e}{m}=\frac{2V}{B^{2}r^{2}}$$
''',
    ),
    LabExperiment(
      number: 14,
      title: 'Piezoelectric Effect Experiment',
      pageRange: '79-84',
      objective:
          'Study direct and inverse piezoelectric effects—mechanical–electrical energy conversion.',
      theory: r'''
Under stress, certain crystals develop charge (direct effect); under electric field, they strain (inverse effect). Equivalent circuits model sensor/actuator behavior.
''',
    ),
    LabExperiment(
      number: 15,
      title: 'Melde’s Experiment',
      pageRange: '85-87',
      objective:
          'Form stationary waves in a string and determine frequency from string parameters.',
      theory: r'''
With length \(l\), tension \(T\), and linear density \( \mu \), for \(n\) loops:
$$f=\frac{n}{2l}\sqrt{\frac{T}{\mu}}$$
''',
    ),
    LabExperiment(
      number: 16,
      title: 'Thermoelectric Generator Experiment',
      pageRange: '88-91',
      objective:
          'Demonstrate Seebeck power generation and study power vs load and temperature difference.',
      theory: r'''
A thermoelectric element develops an emf proportional to temperature difference:
$$E=S\Delta T$$
Power transfer is maximized near load matching; efficiency depends on material figure-of-merit \(ZT\).
''',
    ),
  ];

  // ----------------------- VIRTUAL EXPERIMENTS (UPDATED) -----------------------
  static final List<VirtualExperiment> _virtualExperiments = [
    VirtualExperiment(
      title: 'Thermo Couple – Seebeck Effect',
      module: 'Heat & Thermodynamics',
      platform: 'Virtual Labs (Amrita Vishwa Vidyapeetham)',
      url:
          'https://htv-au.vlabs.ac.in/Thermo_Couple_Seebeck_Effect/experiment.html',
      description:
          'Simulate the Seebeck effect for different thermocouple types, measure thermo-emf versus temperature difference, and estimate the Seebeck coefficient.',
      features: [
        'Choose thermocouple type (e.g., Type R)',
        'Set junction temperatures with sliders',
        'Read generated EMF on a voltmeter',
        'Analyze ΔT vs EMF graph to estimate sensitivity'
      ],
      learningOutcomes: [
        'Verify proportionality of thermocouple EMF to temperature difference (Seebeck effect)',
        'Compare sensitivities of different thermocouple types',
        'Calibrate/estimate the Seebeck coefficient from measured data',
        'Interpret graphs and basic measurement procedure'
      ],
    ),
    VirtualExperiment(
      title: 'Black Body Radiation (Stefan’s Law)',
      module: 'Heat & Thermodynamics',
      platform: 'Virtual Labs (Amrita Vishwa Vidyapeetham)',
      url:
          'https://htv-au.vlabs.ac.in/heat-thermodynamics/Black_Body_Radiation/experiment.html',
      description:
          'Interactive study of black-body radiation. Vary temperatures and observe radiative behavior to validate Stefan–Boltzmann dependence.',
      features: [
        'Adjust source and surrounding temperatures',
        'Use simulator interface with controllable variables',
        'Qualitatively/quantitatively explore power ∝ T⁴ behavior',
        'Connect observations to emissivity and ideal black-body concepts'
      ],
      learningOutcomes: [
        'Understand black-body radiation fundamentals and Stefan–Boltzmann law',
        'Relate temperature to radiative power and peak behavior',
        'Recognize role of emissivity and environment',
        'Practice data reading and basic model fitting'
      ],
    ),
    VirtualExperiment(
      title:
          'Schrödinger’s Equation in the 1-Dimensional Potential Well (MATLAB)',
      module: 'Quantum Mechanics',
      platform: 'MATLAB Central File Exchange',
      url:
          'https://in.mathworks.com/matlabcentral/fileexchange/75495-schrodinger-s-equation-in-the-1-dimensional-potential-well?s_tid=srchtitle_site_search_1_schrodinger%20equation',
      description:
          'MATLAB scripts to compute eigen-energies and eigenfunctions for a 1D bound potential well; runnable locally or in MATLAB Online.',
      features: [
        'Compute bound-state eigen-energies for a 1D potential well',
        'Visualize corresponding wavefunctions',
        'Open directly in MATLAB Online from File Exchange',
        'Explore how well parameters affect quantized levels'
      ],
      learningOutcomes: [
        'Solve the time-independent Schrödinger equation (1D bound states)',
        'Interpret boundary conditions, nodes, and normalization',
        'Connect quantized energies with potential geometry',
        'Build intuition for eigenvalue problems in quantum mechanics'
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
  List<LabExperiment> get _filteredLabExperiments =>
      filterLabExperiments(_labExperiments, _query);

  List<VirtualExperiment> get _filteredVirtualExperiments =>
      filterVirtualExperiments(_virtualExperiments, _query);

  // ----------------------- PDF OPEN HELPERS -----------------------
  static const String _assetPdfPath = 'lib/assets/pdfs/LabManual.pdf';

  Future<String> _ensureLabManualCached() async {
    // Cache the asset into temp dir so external PDF apps can open it.
    final dir = await getTemporaryDirectory();
    final destPath = '${dir.path}/LabManual.pdf';
    final file = File(destPath);
    if (await file.exists()) return destPath;

    final data = await rootBundle.load(_assetPdfPath);
    final bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await file.writeAsBytes(bytes, flush: true);
    return destPath;
  }

  int _startPagePlusTwo(String pageRange) {
    // Extract the first integer in the range and add 2.
    // Handles formats like "01-06", "7–12", "7 — 12", etc.
    final m = RegExp(r'(\d{1,4})').firstMatch(pageRange);
    final first = int.tryParse(m?.group(1) ?? '') ?? 1;
    final page = first + 2;
    return page < 1 ? 1 : page;
  }

  void _toast(ScaffoldMessengerState messenger, String msg) {
    messenger.showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Future<void> _openLabManualFromRange(
      BuildContext context, String pageRange) async {
    // Capture messenger BEFORE any await to avoid using BuildContext after async gaps.
    final messenger = ScaffoldMessenger.of(context);
    final page = _startPagePlusTwo(pageRange);

    if (kIsWeb) {
      // Asset key path appears under /assets/ in Flutter web build
      final assetUrl = 'assets/$_assetPdfPath';
      final candidates = <Uri>[
        Uri.parse('$assetUrl#page=$page'),
        Uri.parse('$assetUrl?page=$page'),
        Uri.parse(assetUrl),
      ];
      for (final uri in candidates) {
        final ok = await launchUrl(uri, mode: LaunchMode.platformDefault);
        if (ok) return;
      }
      _toast(messenger, 'Could not open the PDF in browser.');
      return;
    }

    try {
      final filePath = await _ensureLabManualCached();

      // Try #page=
      final uriWithFragment =
          Uri(scheme: 'file', path: filePath, fragment: 'page=$page');
      var launched = await launchUrl(
        uriWithFragment,
        mode: LaunchMode.externalApplication,
      );

      // Try ?page=
      if (!launched) {
        final uriWithQuery = Uri(
          scheme: 'file',
          path: filePath,
          queryParameters: {'page': '$page'},
        );
        launched = await launchUrl(
          uriWithQuery,
          mode: LaunchMode.externalApplication,
        );
      }

      // Fallback: open normally via OpenFilex
      if (!launched) {
        final res = await OpenFilex.open(filePath, type: 'application/pdf');
        if (res.type != ResultType.done) {
          _toast(messenger, 'Could not open PDF: ${res.message ?? 'Unknown error'}');
        }
      }
    } catch (e) {
      // Last resort: try to open asset without hints via OpenFilex (after cache)
      try {
        final filePath = await _ensureLabManualCached();
        final res = await OpenFilex.open(filePath, type: 'application/pdf');
        if (res.type != ResultType.done) {
          _toast(messenger, 'Failed to open PDF: ${res.message ?? e.toString()}');
        }
      } catch (_) {
        _toast(messenger, 'Failed to open PDF.');
      }
    }
  }

  // ----------------------- UI -----------------------
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Lab Experiments'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          Card(
            elevation: 1,
            color: cs.surfaceContainerHighest,
            shadowColor: cs.shadow,
            surfaceTintColor: cs.surfaceTint,
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
                        hintText: 'Search experiments (title or objective)',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: cs.onSurfaceVariant.withValues(alpha: 0.7)),
                      ),
                      textInputAction: TextInputAction.search,
                      onChanged: (v) => setState(() => _query = v),
                    ),
                  ),
                  if (_query.isNotEmpty)
                    IconButton(
                      tooltip: 'Clear',
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _query = '');
                      },
                    )
                  else
                    IconButton(
                      tooltip: 'Filter',
                      icon: Icon(Icons.filter_list,
                          color: cs.onSurfaceVariant, size: 20),
                      onPressed: () {
                        // Could implement filter functionality here
                      },
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.science_outlined, color: cs.onPrimaryContainer, size: 24),
                const SizedBox(width: 12),
                Text('Lab Experiments',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: cs.onPrimaryContainer)),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: cs.onPrimaryContainer.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${_filteredLabExperiments.length}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: cs.onPrimaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          if (_filteredLabExperiments.isEmpty)
            const _EmptyCard(text: 'No lab experiments match your search.')
          else
            ... _filteredLabExperiments.map(
              (exp) => _LabExperimentCard(
                experiment: exp,
                onOpenManual: _openLabManualFromRange,
              ),
            ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: cs.tertiaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.computer_outlined,
                    color: cs.onTertiaryContainer, size: 20),
                const SizedBox(width: 12),
                Text('Virtual Experiments',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: cs.onTertiaryContainer)),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: cs.onTertiaryContainer.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${_filteredVirtualExperiments.length}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: cs.onTertiaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

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
  final String pageRange;
  final String objective;
  final String theory;
  const LabExperiment({
    required this.number,
    required this.title,
    required this.pageRange,
    required this.objective,
    required this.theory,
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
  final Future<void> Function(BuildContext context, String pageRange)
      onOpenManual;

  const _LabExperimentCard({
    required this.experiment,
    required this.onOpenManual,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bodyStyle = Theme.of(context).textTheme.bodyMedium;

    return Card(
      elevation: 1,
      color: cs.surfaceContainerLowest,
      shadowColor: cs.shadow,
      surfaceTintColor: cs.surfaceTint,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '${experiment.number}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: cs.onPrimaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  experiment.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: cs.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Pages: ${experiment.pageRange}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: cs.onSecondaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          children: [
            const _Subheading(text: 'Objective'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(experiment.objective, style: bodyStyle),
            ),
            const SizedBox(height: 16),
            const _Subheading(text: 'Theory'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: _LaTeXBlock(experiment.theory, style: bodyStyle),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: () => onOpenManual(context, experiment.pageRange),
                icon: const Icon(Icons.picture_as_pdf, size: 18),
                label: const Text('View in lab manual'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VirtualExperimentCard extends StatelessWidget {
  final VirtualExperiment experiment;
  const _VirtualExperimentCard({required this.experiment});

  Future<void> _launchUrl(BuildContext context, String url) async {
    // Capture messenger BEFORE await to avoid using context across async gap.
    final messenger = ScaffoldMessenger.of(context);
    final uri = Uri.parse(url);
    try {
      final ok = await launchUrl(
        uri,
        mode: kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication,
      );
      if (!ok) {
        messenger.showSnackBar(
          SnackBar(
            content: Text('Could not open ${experiment.title}'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('Failed to open link: $e'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      elevation: 1,
      color: cs.surfaceContainerLowest,
      shadowColor: cs.shadow,
      surfaceTintColor: cs.surfaceTint,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(
              child: Text(
                experiment.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface,
                    ),
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
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: cs.onTertiaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ]),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Platform: ${experiment.platform}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            experiment.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: cs.onSurface,
                ),
          ),
          const SizedBox(height: 16),
          const _Subheading(text: 'Features'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: _BulletedList(items: experiment.features),
          ),
          const SizedBox(height: 16),
          const _Subheading(text: 'Learning Outcomes'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: _BulletedList(items: experiment.learningOutcomes),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _launchUrl(context, experiment.url),
                  icon: const Icon(Icons.visibility, size: 18),
                  label: const Text('Preview'),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: cs.outline),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _launchUrl(context, experiment.url),
                  icon: const Icon(Icons.launch, size: 18),
                  label: const Text('Launch'),
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
        ]),
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
      shadowColor: cs.shadow,
      surfaceTintColor: cs.surfaceTint,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: expanded,
          onExpansionChanged: onChanged,
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          title: Row(
            children: [
              Icon(
                Icons.expand_more,
                color: cs.onSurfaceVariant,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Virtual Lab Simulations',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface,
                    ),
              ),
            ],
          ),
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
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: cs.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
        ),
      ],
    );
  }
}

class _BulletedList extends StatelessWidget {
  final List<String> items;
  const _BulletedList({required this.items});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: items
          .map(
            (text) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      color: cs.primary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: cs.onSurface,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

/// Inline + block LaTeX renderer for easy_latex.
///
/// - Inline delimiters: \( ... \)
/// - Block delimiters:  $$ ... $$, \[ ... \]
/// - Sanitizes macros that easy_latex doesn't support (\!, \quad, \qquad, \left, \right, \,, \tfrac, \text{...}).
class _LaTeXBlock extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const _LaTeXBlock(this.text, {this.style});

  @override
  Widget build(BuildContext context) {
    final defaultStyle = style ?? Theme.of(context).textTheme.bodyMedium;
    final tokens = _tokenize(text);

    // Build runs: sequences of inline content collapsed into one RichText,
    // with block equations emitted as their own widgets.
    final children = <Widget>[];
    final inlineBuffer = <_InlinePiece>[];

    void flushInline() {
      if (inlineBuffer.isEmpty) return;
      children.add(
        _InlineRichText(pieces: List.of(inlineBuffer), style: defaultStyle),
      );
      inlineBuffer.clear();
    }

    for (final t in tokens) {
      if (t.kind == _TokKind.blockMath) {
        flushInline();
        final f = _sanitizeLatex(t.content);
        children.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Latex(
                f,
                fontSize: (defaultStyle?.fontSize ?? 16),
                color: defaultStyle?.color ?? Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        );
      } else if (t.kind == _TokKind.inlineMath) {
        inlineBuffer.add(_InlinePiece.math(_sanitizeLatex(t.content)));
      } else {
        if (t.content.isNotEmpty) {
          inlineBuffer.add(_InlinePiece.text(t.content));
        }
      }
    }
    flushInline();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }

  static List<_Token> _tokenize(String input) {
    final re =
        RegExp(r'(\$\$[\s\S]+?\$\$|\\\[[\s\S]+?\\\]|\\\([\s\S]+?\\\))', multiLine: true);
    final out = <_Token>[];
    int last = 0;
    for (final m in re.allMatches(input)) {
      if (m.start > last) {
        out.add(_Token(_TokKind.text, input.substring(last, m.start)));
      }
      final raw = m.group(0)!;
      if (raw.startsWith(r'$$')) {
        out.add(_Token(_TokKind.blockMath, raw.substring(2, raw.length - 2)));
      } else if (raw.startsWith(r'\[')) {
        out.add(_Token(_TokKind.blockMath, raw.substring(2, raw.length - 2)));
      } else {
        out.add(_Token(_TokKind.inlineMath, raw.substring(2, raw.length - 2)));
      }
      last = m.end;
    }
    if (last < input.length) {
      out.add(_Token(_TokKind.text, input.substring(last)));
    }
    return out;
  }

  static String _sanitizeLatex(String s) {
    String t = s;
    // Remove spacing / sizing macros that cause red boxes or odd wraps
    t = t.replaceAll(r'\!', '');
    t = t.replaceAll(r'\,', ' ');
    t = t.replaceAll(r'\quad', ' ');
    t = t.replaceAll(r'\qquad', ' ');
    t = t.replaceAll(r'\left', '');
    t = t.replaceAll(r'\right', '');
    // Replace \tfrac with \frac
    t = t.replaceAll(r'\tfrac', r'\frac');
    // Strip \text{...} -> just its contents
    t = t.replaceAllMapped(RegExp(r'\\text\{([^}]*)\}'), (m) => m.group(1) ?? '');
    // Normalize multiple spaces
    t = t.replaceAll(RegExp(r'\s+'), ' ').trim();
    return t;
  }
}

enum _TokKind { text, inlineMath, blockMath }

class _Token {
  final _TokKind kind;
  final String content;
  _Token(this.kind, this.content);
}

class _InlinePiece {
  final bool isMath;
  final String textOrFormula;
  _InlinePiece.text(this.textOrFormula) : isMath = false;
  _InlinePiece.math(this.textOrFormula) : isMath = true;
}

class _InlineRichText extends StatelessWidget {
  final List<_InlinePiece> pieces;
  final TextStyle? style;
  const _InlineRichText({required this.pieces, this.style});

  @override
  Widget build(BuildContext context) {
    final spans = <InlineSpan>[];
    for (final p in pieces) {
      if (p.isMath) {
        spans.add(
          WidgetSpan(
            baseline: TextBaseline.alphabetic,
            alignment: PlaceholderAlignment.baseline,
            child: Latex(
              p.textOrFormula,
              fontSize: (style?.fontSize ?? 16),
              color: style?.color ?? Theme.of(context).colorScheme.onSurface,
            ),
          ),
        );
      } else {
        // preserve original text (including newlines/spaces)
        spans.add(TextSpan(text: p.textOrFormula, style: style));
      }
    }
    return RichText(text: TextSpan(children: spans, style: style));
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
      shadowColor: cs.shadow,
      surfaceTintColor: cs.surfaceTint,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 48,
              color: cs.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
