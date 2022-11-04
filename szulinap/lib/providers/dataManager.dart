import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager{
  final CollectionReference nameList = FirebaseFirestore.instance.collection('Nevnapok');


}