import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const namedroute = "edit_product_screen";
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageURLController = TextEditingController();
  final _imagURLFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: "", title: "", description: "", imageURL: "", price: 0);
  bool _isInit = true;
  bool isLoading = false;
  var initValues = {
    "title": "",
    "description ": "",
    "price": "",
    "imageURL": ""
  };
  @override
  void initState() {
    _imagURLFocusNode.addListener(updateImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productID = ModalRoute.of(context)?.settings.arguments;
      if (productID != null) {
        _editedProduct = Provider.of<Products>(context, listen: false)
            .findById(productID.toString());
        initValues = {
          "title": _editedProduct.title,
          "price": _editedProduct.price.toString(),
          "description": _editedProduct.description,
          "imageURL": ""
        };
        _imageURLController.text = _editedProduct.imageURL;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imagURLFocusNode.removeListener(updateImage);
    _imagURLFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageURLController.dispose();
    super.dispose();
  }

  void updateImage() {
    if (!_imagURLFocusNode.hasFocus) {
      if ((!_imageURLController.text.startsWith("http") &&
              !_imageURLController.text.startsWith("https")) ||
          (!_imageURLController.text.endsWith(".jpg") &&
              !_imageURLController.text.endsWith(".jpeg") &&
              !_imageURLController.text.endsWith(".png"))) return;
    }
    setState(() {});
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState?.validate();

    if (isValid == false) {
      return;
    } else {
      _form.currentState?.save();
      setState(() {
        isLoading = true;
      });

      if (_editedProduct.id != "") {
        Provider.of<Products>(context, listen: false)
            .updateProduct(_editedProduct.id, _editedProduct);
        Navigator.pop(context);
        setState(() {
          isLoading = false;
        });
      } else {
        try {
          await Provider.of<Products>(context, listen: false)
              .addProduct(_editedProduct);
        } catch (e) {
          return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                      title: const Text("An Error occured"),
                      content: const Text("Something Went Wrong"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Okay")),
                      ]));
        } finally {
          setState(() {
            isLoading = false;
            Navigator.pop(context);
            if (Provider.of<Products>(context, listen: false)
                .items
                .contains(_editedProduct)) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                'Item Added',
                textAlign: TextAlign.center,
              )));
            }
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          TextButton.icon(
            onPressed: () {
              _saveForm();
            },
            icon: Icon(Icons.save),
            label: Text("Save"),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.amber)),
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: initValues["title"],
                        decoration: const InputDecoration(labelText: "Title"),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter the title";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
                              title: value.toString(),
                              description: _editedProduct.description,
                              imageURL: _editedProduct.imageURL,
                              price: _editedProduct.price);
                        },
                      ),
                      TextFormField(
                        initialValue: initValues["price"],
                        decoration: InputDecoration(labelText: "Price"),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a value";
                          }
                          if (double.tryParse(value) == null) {
                            return "please enter valid price";
                          }
                          if (double.parse(value) <= 0) {
                            return "Please enter A price greater than 0";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              imageURL: _editedProduct.imageURL,
                              price: double.parse(value!));
                        },
                      ),
                      TextFormField(
                        initialValue: initValues["description"],
                        decoration: InputDecoration(labelText: "Description"),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
                              title: _editedProduct.title,
                              description: value.toString(),
                              imageURL: _editedProduct.imageURL,
                              price: _editedProduct.price);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter some Description";
                          }
                          if (value.length < 10) {
                            return "The description hould be at least 10 character";
                          }
                          return null;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              height: 150,
                              width: 100,
                              margin: EdgeInsets.only(top: 10, right: 8),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              child: _imageURLController.text.isEmpty
                                  ? Text("Enter Image URl ")
                                  : FittedBox(
                                      child: Image.network(
                                          _imageURLController.text),
                                      fit: BoxFit.contain,
                                    ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Image URL"),
                              controller: _imageURLController,
                              textInputAction: TextInputAction.done,
                              focusNode: _imagURLFocusNode,
                              onFieldSubmitted: (_) {
                                _saveForm();
                              },
                              onSaved: (value) {
                                _editedProduct = Product(
                                    id: _editedProduct.id,
                                    isFavorite: _editedProduct.isFavorite,
                                    title: _editedProduct.title,
                                    description: _editedProduct.description,
                                    imageURL: value.toString(),
                                    price: _editedProduct.price);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter the image URl ";
                                }
                                if (!value.startsWith("http") &&
                                    !value.startsWith("https")) {
                                  return " please enter a valid url";
                                }
                                if (!value.endsWith(".jpg") &&
                                    !value.endsWith(".jpeg") &&
                                    !value.endsWith(".png")) {
                                  return "Please enter valid url";
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
    );
  }
}
