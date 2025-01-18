import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewDatabase extends StatelessWidget {
  // final String collectionName;
  // ViewDatabase({required this.collectionName});

  Future<void> fetchData() async {
    try {
      final collection = FirebaseFirestore.instance.collection('bomer');
      final snapshot = await collection.get();

      if (snapshot.docs.isEmpty) {
        print('No data found in bomer');
      } else {
        for (var item in snapshot.docs) {
          print('Name: ${item['name']}, Phone Number: ${item['phno']}');
        }
      }
    } catch (e) {
      print('Error: ${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                ElevatedButton(onPressed: fetchData, child: Text('Click me'))));
  }
}
