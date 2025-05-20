import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test20052025/presentation/screens/scan_detail_screen.dart';

import '../../data/model/scan_model.dart';
import '../viewmodel/scan_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ScanViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Stock Scan Parser")),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: viewModel.scans.length,
        itemBuilder: (context, index) {
          final scan = viewModel.scans[index];
          return Card(
            margin: const EdgeInsets.all(8),
            color: scan.color == 'green' ? Colors.green[50] : Colors.red[50],
            child: ListTile(
              title: Text(scan.name),
              subtitle: Text(
                scan.tag,
                style: TextStyle(
                  color: scan.color == 'green' ? Colors.green : Colors.red,
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScanDetailScreen(scan: scan),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}