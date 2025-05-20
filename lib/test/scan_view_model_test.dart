import 'package:flutter_test/flutter_test.dart';

import '../presentation/viewmodel/scan_view_model.dart';

void main() {
  test("Fetch scans data", () async {
    final vm = ScanViewModel();
    await vm.loadScans();
    expect(vm.scans.isNotEmpty, true);
  });
}
