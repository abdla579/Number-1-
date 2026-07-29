class SparePart {
  final String name;
  final String price;
  final String currency;
  final String notes;

  SparePart({
    required this.name,
    required this.price,
    this.currency = 'EGP',
    this.notes = '',
  });

  factory SparePart.fromJson(Map<String, dynamic> json) {
    return SparePart(
      name: json['name'] ?? '',
      price: json['price']?.toString() ?? '',
      currency: json['currency'] ?? 'EGP',
      notes: json['notes'] ?? '',
    );
  }
}

class RepairCode {
  final String title;
  final String code;
  final String description;

  RepairCode({
    required this.title,
    required this.code,
    this.description = '',
  });

  factory RepairCode.fromJson(Map<String, dynamic> json) {
    return RepairCode(
      title: json['title'] ?? '',
      code: json['code'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class PhoneModel {
  final String id;
  final String brand;
  final String model;
  final String? pdf;
  final List<SparePart> parts;
  final List<RepairCode> codes;

  PhoneModel({
    required this.id,
    required this.brand,
    required this.model,
    this.pdf,
    required this.parts,
    required this.codes,
  });

  String get fullName => '$brand $model';

  factory PhoneModel.fromJson(Map<String, dynamic> json) {
    return PhoneModel(
      id: json['id'].toString(),
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      pdf: json['pdf'],
      parts: (json['parts'] as List<dynamic>? ?? [])
          .map((e) => SparePart.fromJson(e))
          .toList(),
      codes: (json['codes'] as List<dynamic>? ?? [])
          .map((e) => RepairCode.fromJson(e))
          .toList(),
    );
  }
}
