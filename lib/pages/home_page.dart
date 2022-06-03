import 'package:flutter/material.dart';
import 'package:shopping_sql_project/db/products_database.dart';
import 'package:shopping_sql_project/models/product.dart';
import 'package:shopping_sql_project/pages/add_product_page.dart';
import 'package:shopping_sql_project/pages/edit_product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product>? products;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  @override
  void dispose() {
    ProductsDatabase.instance.close();
    super.dispose();
  }

  Future getNotes() async {
    setState(() {
      isLoading = true;
    });
    products = await ProductsDatabase.instance.readAllProducts();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        leading: const Icon(Icons.shopping_cart_outlined),
        title: const Text('Shopping App'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : products!.isEmpty
              ? const Center(
                  child: Text(
                  'No products added yet!',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ))
              : buildList(),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => AddProductPage(
                    addProduct: (productInfo, productQuantity) async {
                      await ProductsDatabase.instance.create(Product(
                          name: productInfo, quantity: productQuantity));

                      Navigator.pop(context);
                      getNotes();
                    },
                  ));
        },
      ),
    );
  }

  Widget buildList() {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(8.0),
        itemCount: products!.length,
        itemBuilder: (context, index) {
          final product = products![index];
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              tileColor: Colors.indigo,
              leading: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
              title: Text(
                'Product: ' + product.name,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                'Quantity: ' + product.quantity.toString(),
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditProductPage(product: product)));
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }
}
