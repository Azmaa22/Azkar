import 'dart:convert';

import 'package:flutter/services.dart';

Future<void> test() async {
  final String response =
      await rootBundle.loadString('assets/static_data/db.json');
  Map<String, dynamic> azkar = jsonDecode(response);
  print('data ${azkar['Morning']}');
}
