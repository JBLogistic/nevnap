import 'dart:io';
import 'package:flutter/material.dart';

class CheckThings {

  Future internet(String _IP) async {
    try {
      final result = await InternetAddress.lookup(_IP);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (e) {
      print(e.toString());
      return false;
    }
  }

}