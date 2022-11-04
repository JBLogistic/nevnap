import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:szulinap/providers/Database.dart';
class Names {
  String id = "";
  String name = "";
  String date = "";

  Names({
    required this.name,
    required this.date,
    required this.id,
  });


}