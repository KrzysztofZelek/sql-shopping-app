import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  AddProductPage(
      {Key? key,
      this.productInfo,
      this.productQuantity,
      required this.addProduct})
      : super(key: key);

  String? productInfo;
  int? productQuantity;
  final Function addProduct;

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.blue[200],
      ),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Product information',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    label: Text('Add product info'),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  controller: textController,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'You can\'t leave this space empty!';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    textController.text = value;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      label: Text('Add product quantity'),
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 1,
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'You can\'t leave this space empty!';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      quantityController.text = value;
                    }),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    final isValid = formKey.currentState!.validate();
                    if (isValid) {
                      widget.productInfo = textController.text;
                      widget.productQuantity =
                          int.parse(quantityController.text);
                      widget.addProduct(
                          widget.productInfo, widget.productQuantity);
                    }
                  },
                  child: const Center(
                      child: Text(
                    'Add product to the list',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
