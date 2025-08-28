import 'package:flutter_test/flutter_test.dart';
import 'package:IEMPhysics/theory_page.dart';

void main() {
  test('filterModules matches query across fields', () {
    final modules = [
      ModuleItem(
        number: 1,
        title: 'Mechanics',
        lectureHours: 1,
        sections: [
          ModuleSection(heading: 'Intro', bullets: ['Friction'])
        ],
        academiaLinks: const [],
        industryLinks: const [],
        textbooks: const [
          BookItem(title: 'Mechanics Book', storeUrl: '')
        ],
        labAssignments: const ['Friction lab'],
      ),
      ModuleItem(
        number: 2,
        title: 'Optics',
        lectureHours: 1,
        sections: const [],
        academiaLinks: const [],
        industryLinks: const [],
        textbooks: const [],
        labAssignments: const [],
      ),
    ];

    expect(filterModules(modules, ''), hasLength(2));
    expect(filterModules(modules, 'mechanics'), hasLength(1));
    expect(filterModules(modules, 'friction'), hasLength(1));
    expect(filterModules(modules, 'optics').first.title, 'Optics');
  });
}
