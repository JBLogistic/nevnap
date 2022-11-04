import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:szulinap/main.dart';
import 'package:szulinap/screens/login_screen.dart';
import 'package:szulinap/providers/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/Database.dart';
import 'package:intl/intl.dart';

import '../providers/names.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  var db = FirebaseFirestore.instance;
  CollectionReference names = FirebaseFirestore.instance.collection('Nevnapok');

  List<String> docIds = [];
  List<Names> items = [];
  void getItems(){
    for(int i =0; i < docIds.length ;i++){

    }
  }
  Future getIds() async{
    await names.get().then((snapshot) => snapshot.docs.forEach(
            (document){
          docIds.add(document.reference.id);
        }
    ));
  }
  String todayName(List<String> docIds ){
    String tdata = DateFormat("yyyy-MM-dd").format(DateTime.now());
    for(int i =0; i < docIds.length ;i++){
      Widget a = Database2(docID: docIds[i]);
      if(a!=null){
          return docIds[i];
      }
    }
    return 'Error';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        height: double.infinity,
        margin: const EdgeInsets.all(24.0),
        alignment: Alignment.center,
        child:FutureBuilder(
            future: getIds(),
            builder:(context,snapshot){ return ListView.builder(
            itemCount: docIds.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children:[
                  Container(
                  child: Database(docID: docIds[index]),
                  decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent)
                    ),
                  padding: const EdgeInsets.all(3.0),
                    margin: const EdgeInsets.all(3.0)
                  )]

    );},
      );})),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Options',
                style: TextStyle(fontSize: 18),
              ),
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                AuthService().signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const SzulinapApp() ));
              },
            ),
            ListTile(
              title: const Text('Mai nevnap'),
              onTap: () {
                Navigator.pop(context);
                showDialog(context: context, builder: (BuildContext context) {
                  if(todayName(docIds) != 'Error')
                    return AlertDialog(
                      title: Text("A ami nevnaposunk"),
                      content: Database(docID: todayName(docIds)));
                  else
                    return AlertDialog(
                        title: Text("A ami nevnaposunk"),
                        content:Text('Van egy pici gebasz'));
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
