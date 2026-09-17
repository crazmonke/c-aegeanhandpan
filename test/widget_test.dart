import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:c_aegean_handpan/core/constants/tone_field_catalog.dart';
import 'package:c_aegean_handpan/core/models/tone_field.dart';
import 'package:c_aegean_handpan/widgets/handpan_board.dart';

void main() {
  testWidgets('HandpanBoard renders all 9 tone fields and reports taps', (tester) async {
    ToneField? tapped;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 300,
            height: 300,
            child: HandpanBoard(
              fields: toneFieldCatalog,
              showLabels: true,
              onTapField: (field) => tapped = field,
            ),
          ),
        ),
      ),
    );

    // Ding + 8 note labels should all be on screen.
    expect(find.text('C3'), findsOneWidget);
    expect(find.text('E3'), findsOneWidget);
    expect(find.text('B4'), findsOneWidget);

    await tester.tap(find.text('C3'));
    await tester.pump();

    expect(tapped?.key, 'ding');
  });
}
