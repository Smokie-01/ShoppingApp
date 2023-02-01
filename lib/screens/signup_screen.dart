import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopapp/screens/product_overview.dart';

const url = "https://shopping-app-1c5aa-default-rtdb.firebaseio.com/users.json";

class SignUpScreen extends StatefulWidget {
  static const namedRoute = "sign_up_screen";
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _name = "";
  String _email = "";
  String _password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameControlller = TextEditingController();

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid == true) {
      final userDetail = _formKey.currentState!.save();
      try {
        final newUser = await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        await _firestore
            .collection("users")
            .add({"name": _name, "email": _email, "password": _password});
      } catch (e) {
        print(e);
      }

      emailController.clear();
      passwordController.clear();
      nameControlller.clear();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Name '),
              controller: nameControlller,
              validator: (value) {
                return !RegExp(r'^[a-zA-Z ]+$').hasMatch(value!)
                    ? 'Please enter a valid name'
                    : null;
              },
              onSaved: ((newValue) => _name = newValue!),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                return !RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!)
                    ? 'Please enter a valid email address'
                    : null;
              },
              onSaved: (value) => _email = value!,
              controller: emailController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: ((value) {
                return value!.length < 6
                    ? "more than 6 character needed "
                    : null;
              }),
              onSaved: (input) => _password = input!,
              controller: passwordController,
            ),
            ElevatedButton(
              onPressed: () {
                // _saveForm();
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
