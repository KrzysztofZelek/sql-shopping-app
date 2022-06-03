final String tableProducts = 'products';

class ProductFields {
  static final List<String> values = [id, name, quantity];

  static final String id = '_id';
  static final String name = 'name';
  static final String quantity = 'quantity';
}

class Product {
  Product({
    this.id,
    required this.name,
    required this.quantity,
  });
  final int? id;
  final String name;
  final int quantity;

  Product copy({
    int? id,
    String? name,
    int? quantity,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        quantity: quantity ?? this.quantity,
      );

  Map<String, dynamic> toJson() => {
        ProductFields.id: id,
        ProductFields.name: name,
        ProductFields.quantity: quantity,
      };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json[ProductFields.id],
      name: json[ProductFields.name],
      quantity: json[ProductFields.quantity]);
}
