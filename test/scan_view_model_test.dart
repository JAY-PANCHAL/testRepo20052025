
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test20052025/data/model/scan_model.dart';
import 'package:test20052025/presentation/viewmodel/scan_view_model.dart';
import 'mocks/mock_api_service.mocks.dart';

void main() {
  group('ScanViewModel', () {
    late ScanViewModel viewModel;
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      viewModel = ScanViewModel(apiService: mockApiService);
    });

    test('loads scans successfully', () async {
      final dummyScan = ScanModel(
        name: 'Dummy',
        tag: 'Test',
        color: 'green',
        criteria: [],
        id: 1,
      );

      when(mockApiService.fetchScans()).thenAnswer((_) async => [dummyScan]);

      await viewModel.loadScans();

      expect(viewModel.isLoading, false);
      expect(viewModel.scans.length, 1);
      expect(viewModel.scans.first.name, 'Dummy');
    });
  });
}
