import 'package:flutter/material.dart';
import '../models/phone_model.dart';
import 'pdf_viewer_screen.dart';

class ModelDetailScreen extends StatelessWidget {
  final PhoneModel phone;

  const ModelDetailScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(phone.fullName)),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          if (phone.pdf != null && phone.pdf!.isNotEmpty)
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: ListTile(
                leading: const Icon(Icons.picture_as_pdf),
                title: const Text('عرض مخطط الهاتف (Schematic)'),
                trailing: const Icon(Icons.open_in_new),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PdfViewerScreen(
                        pdfAssetPath: 'assets/pdfs/${phone.pdf}',
                        title: '${phone.fullName} - Schematic',
                      ),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 12),
          _sectionTitle('قطع الغيار والأسعار'),
          if (phone.parts.isEmpty)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('لا توجد قطع مسجلة لهذا الموديل بعد.'),
            ),
          ...phone.parts.map(
            (part) => Card(
              child: ListTile(
                title: Text(part.name),
                subtitle: part.notes.isNotEmpty ? Text(part.notes) : null,
                trailing: Text(
                  '${part.price} ${part.currency}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _sectionTitle('أكواد صيانة مهمة'),
          if (phone.codes.isEmpty)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('لا توجد أكواد مسجلة لهذا الموديل بعد.'),
            ),
          ...phone.codes.map(
            (code) => Card(
              child: ListTile(
                title: Text(code.title),
                subtitle: code.description.isNotEmpty
                    ? Text(code.description)
                    : null,
                trailing: SelectableText(
                  code.code,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
