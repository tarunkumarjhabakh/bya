// custom_widget.dart
import 'package:flutter/material.dart';
import 'firestore_handler.dart'; // Import your Firestore handler file

class DummyWidget extends StatelessWidget {
  final String collectionName;

  DummyWidget({required this.collectionName});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: getData("nobs"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No data found"));
            }

            // Display data if fetched successfully
            var data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var person = data[index];
                return ListTile(
                  title: Text(person['name'] ?? 'No Name'),
                  subtitle: Text('Age: ${person['age']}'),
                );
              },
            );
          },
        ));
  }
}
