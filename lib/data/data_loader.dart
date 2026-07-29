import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/phone_model.dart';

class DataLoader {
  static List<PhoneModel>? _cache;

  static Future<List<PhoneModel>> loadPhones() async {
    if (_cache != null) return _cache!;
    final String jsonString =
        await rootBundle.loadString('assets/data/phones_data.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    _cache = jsonList.map((e) => PhoneModel.fromJson(e)).toList();
    return _cache!;
  }

  static List<PhoneModel> search(List<PhoneModel> all, String query) {
    if (query.trim().isEmpty) return all;
    final q = query.trim().toLowerCase();
    return all.where((phone) {
      return phone.brand.toLowerCase().contains(q) ||
          phone.model.toLowerCase().contains(q) ||
          phone.fullName.toLowerCase().contains(q);
    }).toList();
  }
}
