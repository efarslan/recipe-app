import 'package:flutter/material.dart';
import '../widgets/category_item.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tarif.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchWord = "";
  String? seciliKategori;
  List<Tarif> tarifler = [];
  @override
  void initState() {
    super.initState();
    fetchTarifler().then((value) {
      setState(() {
        tarifler = value;
      });
    });
  }

  Future<List<Tarif>> fetchTarifler() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/tarifler'));

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((e) => Tarif.fromJson(e)).toList();
    } else {
      throw Exception('Tarifler alınırken bir hata oluştu.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final gosterilecekTarifler = seciliKategori == null
        ? tarifler
        : tarifler.where((t) => t.kategori == seciliKategori).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFf7f7f7),
      appBar: AppBar(title: const Text("Tarifler")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Tarif Ara...",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchWord = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: SizedBox(
                height: 200,
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    CategoryItem(
                      imagePath: 'assets/icons/coffee.png',
                      label: 'Kahve',
                      onTap: () {
                        setState(() {
                          seciliKategori = 'Kahve';
                        });
                      },
                    ),
                    CategoryItem(
                      imagePath: 'assets/icons/dessert.png',
                      label: 'Tatlı',
                      onTap: () {
                        setState(() {
                          seciliKategori = 'Tatlı';
                        });
                      },
                    ),
                    CategoryItem(
                      imagePath: 'assets/icons/drink.png',
                      label: 'İçecek',
                      onTap: () {
                        setState(() {
                          seciliKategori = 'İçecek';
                        });
                      },
                    ),
                    CategoryItem(
                      imagePath: 'assets/icons/meat.png',
                      label: 'Et',
                      onTap: () {
                        setState(() {
                          seciliKategori = 'Et';
                        });
                      },
                    ),
                    CategoryItem(
                      imagePath: 'assets/icons/home.png',
                      label: 'Ev Yemeği',
                      onTap: () {
                        setState(() {
                          seciliKategori = 'Ev Yemeği';
                        });
                      },
                    ),
                    CategoryItem(
                      imagePath: 'assets/icons/breakfast.png',
                      label: 'Kahvaltı',
                      onTap: () {
                        setState(() {
                          seciliKategori = 'Kahvaltı';
                        });
                      },
                    ),
                    CategoryItem(
                      imagePath: 'assets/icons/pastry.png',
                      label: 'Hamur İşi',
                      onTap: () {
                        setState(() {
                          seciliKategori = 'Hamur İşi';
                        });
                      },
                    ),
                    CategoryItem(
                      imagePath: 'assets/icons/soup.png',
                      label: 'Çorba',
                      onTap: () {
                        setState(() {
                          seciliKategori = 'Çorba';
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: gosterilecekTarifler.length,
                itemBuilder: (context, index) {
                  final tarif = gosterilecekTarifler[index];
                  return ListTile(
                    title: Text(tarif.isim),
                    subtitle: Text(tarif.kategori),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
