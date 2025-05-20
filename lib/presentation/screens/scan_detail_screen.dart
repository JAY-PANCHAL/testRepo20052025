import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../data/model/scan_model.dart';

class ScanDetailScreen extends StatelessWidget {
  final ScanModel scan;

  const ScanDetailScreen({super.key, required this.scan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(scan.name),
            Text(
              scan.tag,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: scan.criteria.length,
        itemBuilder: (context, index) {
          final criteria = scan.criteria[index];

          if (criteria.type == 'plain_text') {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(normalizeText(criteria.text),style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,
                overflow: TextOverflow.visible,
              ),
                softWrap: true,
                maxLines: null,),
            );
          } else if (criteria.type == 'variable') {
            final spans = <TextSpan>[];
            final variableKeys = criteria.variable?.keys.toList() ?? [];
            String remaining = criteria.text;
            for (final key in variableKeys) {
              final idx = remaining.indexOf(key);
              if (idx != -1) {
                spans.add(TextSpan(text: normalizeText(remaining).substring(0, idx),
                  style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),));
                spans.add(
                  TextSpan(
                    text: key,
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        final value = criteria.variable![key];
                        showDialog(
                          context: context,
                          builder: (_) {
                            if (value['type'] == 'value') {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List<Widget>.from(
                                    (value['values'] as List).map((val) => Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                      child: Text("• $val"),
                                    )),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Close"),
                                  )
                                ],
                              );
                            } else if (value['type'] == 'indicator') {
                              final TextEditingController controller =
                              TextEditingController(text: value['default_value'].toString());
                              return AlertDialog(
                              //  title: Text("$key"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${value['study_type']}", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                                    SizedBox(height: 10,),
                                    //Text("Set ${value['parameter_name']}"),
                                   // Text("Min: ${value['min_value']}, Max: ${value['max_value']}"),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: controller,
                                      keyboardType: TextInputType.number,
                                      decoration:  InputDecoration(
                                        labelText: "Enter ${value['parameter_name']}",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Close"),
                                  )
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        );
                      },
                  ),
                );
                remaining = remaining.substring(idx + key.length);
              }
            }

            if (remaining.isNotEmpty) {
              spans.add(TextSpan(text: remaining));
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: spans,
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
  String normalizeText(String input) {
    return input
        .replaceAll('’', "'")
        .replaceAll('‘', "'")
        .replaceAll('“', '"')
        .replaceAll('”', '"')
        .replaceAll('\u003C', '<');
  }

}
