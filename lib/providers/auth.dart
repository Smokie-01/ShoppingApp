import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/models/http_exception.dart';

const signUPurl =
    "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAB_Ze1mX8tVaDlkKHxldtR330jfAeNlII";
const logINurl =
    "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAB_Ze1mX8tVaDlkKHxldtR330jfAeNlII";

class Auth with ChangeNotifier {
  String _token = "";
  String _userID = "";
  DateTime _expiryDate = DateTime.now();

  Future<void> signUP(String email, String password) async {
    try {
      Uri uri = Uri.parse(signUPurl);
      final resposne = await http.post(
        uri,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );
      final responseData = jsonDecode(resposne.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logIN(String email, String password) async {
    try {
      Uri uri = Uri.parse(logINurl);
      final response = await http.post(uri,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
    } catch (e) {
      rethrow;
    }
  }
}
