class Tarif {
  final int id;
  final String isim;
  final String kategori;

  Tarif({required this.id, required this.isim, required this.kategori});

  factory Tarif.fromJson(Map<String, dynamic> json) {
    return Tarif(
      id: json['id'],
      isim: json['isim'],
      kategori: json['kategori'],
    );
  }
}
