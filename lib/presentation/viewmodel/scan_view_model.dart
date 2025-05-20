import 'package:flutter/material.dart';
import '../../data/model/scan_model.dart';
import '../../data/services/api_service.dart';

class ScanViewModel extends ChangeNotifier {
  final ApiService _apiService;

  ScanViewModel({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  List<ScanModel> scans = [];
  bool isLoading = false;

  Future<void> loadScans() async {
    isLoading = true;
    notifyListeners();
    try {
      scans = await _apiService.fetchScans();
    } catch (e) {
      print("Error: $e");
    }
    isLoading = false;
    notifyListeners();
  }
}
