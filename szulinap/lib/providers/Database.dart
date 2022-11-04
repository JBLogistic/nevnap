import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
class Database extends StatelessWidget {
  final String docID;
  Database({required this.docID});

  @override
  Widget build(BuildContext context) {
    CollectionReference names = FirebaseFirestore.instance.collection('Nevnapok');
    return FutureBuilder<DocumentSnapshot>(
        future: names.doc(docID).get(),
        builder: ((context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic> data = snapshot.data!.data() as Map <String, dynamic>;
            return Text('Nevnap : ${data['Name']}\t ${data['Date']}');
          }
          return Text('Loading..');
        }
        )
    );
  }
}
class Database2 extends StatelessWidget {
  final String docID;
  Database2({required this.docID});

  @override
  Widget build(BuildContext context) {
    CollectionReference names = FirebaseFirestore.instance.collection('Nevnapok');
    return FutureBuilder<DocumentSnapshot>(
        future: names.doc(docID).get(),
        builder: ((context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic> data = snapshot.data!.data() as Map <String, dynamic>;
              return Text('1');
          }
          return Text('');
        }

        )
    );
  }
}