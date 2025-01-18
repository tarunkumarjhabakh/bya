import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<List<Map<String, dynamic>>> loadJson() async {
  String jsonString = await rootBundle.loadString('assets/home_page.json');
  return List<Map<String, dynamic>>.from(json.decode(jsonString));
}

class Rect extends StatelessWidget {
  final int id;
  const Rect({required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80, 
      color: Colors.grey, 
      margin: EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.center,
      child: Text(
        'Rect $id',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: loadJson(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error loading data", style: TextStyle(color: Colors.red, fontSize: 20));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return CircularProgressIndicator();
            }

            List<Map<String, dynamic>> rectangles = snapshot.data!;

            return Column(
              children: rectangles.map((rect) => Rect(id: rect['rect'])).toList(),
            );
          },
        ),
      ),
    );
  }
}