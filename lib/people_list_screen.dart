import 'package:flutter/material.dart';
import 'firestore_handler.dart'; // Import the Firestore handler file

class PeopleListScreen extends StatelessWidget {
  final String collectionName;

  PeopleListScreen({required this.collectionName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('People List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getData(collectionName), // Call getData function to fetch data
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
      ),
    );
  }
}
