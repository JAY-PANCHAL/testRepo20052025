import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:test20052025/presentation/screens/home_screen.dart';
import 'package:test20052025/presentation/viewmodel/scan_view_model.dart';
import 'package:test20052025/data/model/scan_model.dart';

void main() {
  testWidgets('HomeScreen shows list of scans', (WidgetTester tester) async {
    // Dummy data for testing
    final dummyScans = [
      ScanModel(id: 1,name: 'Scan 1', tag: 'tag1', color: 'green', criteria: []),
      ScanModel(id:2,name: 'Scan 2', tag: 'tag2', color: 'red', criteria: []),
    ];

    // Create a ScanViewModel with dummy data
    final scanViewModel = ScanViewModel();
    scanViewModel.scans = dummyScans;
    scanViewModel.isLoading = false;

    // Build our widget tree with Provider injecting the ScanViewModel
    await tester.pumpWidget(
      ChangeNotifierProvider<ScanViewModel>.value(
        value: scanViewModel,
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    // Allow widget to build
    await tester.pump();

    // Verify that scan names are displayed
    expect(find.text('Scan 1'), findsOneWidget);
    expect(find.text('Scan 2'), findsOneWidget);
  });
}
