import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/scan_model.dart';

class ApiService {
  Future<List<ScanModel>> fetchScans() async {
    final url = Uri.parse("http://coding-assignment.bombayrunning.com/data.json");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final List data = json.decode(decodedBody);
      return data.map((e) => ScanModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load data");
    }
  }}
