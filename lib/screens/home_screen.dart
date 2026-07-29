import 'package:flutter/material.dart';
import '../data/data_loader.dart';
import '../models/phone_model.dart';
import 'model_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PhoneModel> _allPhones = [];
  List<PhoneModel> _filteredPhones = [];
  bool _loading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final phones = await DataLoader.loadPhones();
    setState(() {
      _allPhones = phones;
      _filteredPhones = phones;
      _loading = false;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredPhones = DataLoader.search(_allPhones, query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صيانة الموبايل - قطع الغيار'),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      hintText: 'ابحث بالموديل أو الماركة',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                  ),
                ),
                Expanded(
                  child: _filteredPhones.isEmpty
                      ? const Center(child: Text('لا توجد نتائج'))
                      : ListView.builder(
                          itemCount: _filteredPhones.length,
                          itemBuilder: (context, index) {
                            final phone = _filteredPhones[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              child: ListTile(
                                leading: const Icon(Icons.phone_android,
                                    size: 32),
                                title: Text(
                                  phone.fullName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    '${phone.parts.length} قطعة غيار متاحة'),
                                trailing: const Icon(Icons.arrow_forward_ios,
                                    size: 16),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          ModelDetailScreen(phone: phone),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
