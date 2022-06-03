import 'package:flutter/material.dart';
import 'package:shopping_sql_project/db/products_database.dart';
import 'package:shopping_sql_project/main.dart';
import 'package:shopping_sql_project/models/product.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final formKey = GlobalKey<FormState>();
  bool isAssigned = false;
  String? name;
  int? quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: const Text('Edit product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Edit product name'),
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.product.name,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'You can\'t leave this space empty!';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    name = value;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Edit product quantity'),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: widget.product.quantity.toString(),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'You can\'t leave this space empty!';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    quantity = int.parse(value);
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    final isValid = formKey.currentState!.validate();
                    if (isValid) {
                      await ProductsDatabase.instance.update(Product(
                          id: widget.product.id,
                          name: name ?? widget.product.name,
                          quantity: quantity ?? widget.product.quantity));

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ShoppingApp()));
                    }
                  },
                  child: const Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await ProductsDatabase.instance
                        .delete(widget.product.id as int);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ShoppingApp()));
                  },
                  child: const Center(
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
