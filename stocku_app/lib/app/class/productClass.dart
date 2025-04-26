class Product {
  String namaCat;
  String namaProduk;
  String ID;
  int stok;
  int harga;
  String deskripsi;

  Product({
    required this.namaCat,
    required this.namaProduk,
    required this.ID,
    required this.stok,
    required this.harga,
    required this.deskripsi
  });

  Map<String, dynamic> toJson() {
    return {
      'id': ID,
      'namaProduk': namaProduk,
      'kategori': namaCat,
      'harga': harga,
      'stok': stok,
      'deskripsi': deskripsi,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json, String namaCat) {
    return Product(
      ID: json['ID'] ?? '',
      namaProduk: json['Produk'] ?? '',
      namaCat: namaCat,
      harga: int.tryParse(json['harga']?.toString() ?? '') ?? 0,
      stok: int.tryParse(json['Stok']?.toString() ?? '') ?? 0,
      deskripsi: json['deskripsi'] ?? '',
    );
  }
}
