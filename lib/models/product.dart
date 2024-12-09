class Product {
  final int id;
  final String title;
  final double price;
  final String photo;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.photo});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      photo: json['photo'],
    );
  }
}
