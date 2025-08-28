import 'package:flutter_test/flutter_test.dart';
import 'package:IEMPhysics/lab_page.dart';

void main() {
  test('filterLabExperiments matches by title or objective', () {
    final labs = [
      LabExperiment(
        number: 1,
        title: 'Resistance',
        pageRange: '1-2',
        objective: 'Measure resistance',
        theory: 'N/A',
      ),
      LabExperiment(
        number: 2,
        title: 'Oscillation',
        pageRange: '3-4',
        objective: 'Study oscillation',
        theory: 'N/A',
      ),
    ];

    expect(filterLabExperiments(labs, ''), hasLength(2));
    expect(filterLabExperiments(labs, 'osc'), hasLength(1));
    expect(filterLabExperiments(labs, 'resistance').first.number, 1);
  });

  test('filterVirtualExperiments searches multiple fields', () {
    final virtuals = [
      VirtualExperiment(
        title: 'Pendulum',
        module: 'Mechanics',
        platform: 'Web',
        url: 'http://example.com',
        description: 'Simple pendulum simulation',
        features: const ['period'],
        learningOutcomes: const [],
      ),
      VirtualExperiment(
        title: 'Diffraction',
        module: 'Optics',
        platform: 'Web',
        url: 'http://example.com',
        description: 'Wave diffraction',
        features: const ['fringe'],
        learningOutcomes: const [],
      ),
    ];

    expect(filterVirtualExperiments(virtuals, ''), hasLength(2));
    expect(filterVirtualExperiments(virtuals, 'pendulum'), hasLength(1));
    expect(filterVirtualExperiments(virtuals, 'fringe').first.title, 'Diffraction');
  });
}
