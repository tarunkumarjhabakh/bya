import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_widget.dart';
import 'custom_rectangle.dart';
import 'firestore_handler.dart';
import 'dummy_widget.dart';
import 'people_list_screen.dart';

Future<List<Map<String, dynamic>>> loadJson() async {
  String jsonString = await rootBundle.loadString('assets/home_page.json');
  return List<Map<String, dynamic>>.from(json.decode(jsonString));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getData("nobs"); // Call the getData function for Firestore

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SingleChildScrollView(
        // Wrap the Column inside SingleChildScrollView
        child: Center(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            // Fetching data from assets
            future: loadJson(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(
                  "Error loading data",
                  style: TextStyle(color: Colors.red, fontSize: 20),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return CircularProgressIndicator();
              }

              List<Map<String, dynamic>> widgets = snapshot.data!;

              return Column(
                children: [
                  // Dynamic widgets from JSON
                  ...widgets.map((widgetData) {
                    return HomeWidget(
                      name: widgetData['name'],
                      count: widgetData['count'],
                    );
                  }).toList(),
                  SizedBox(
                      height:
                          20), // Spacer between dynamic widgets and CustomRectangles

                  DummyWidget(collectionName: 'nobs'),

                  // 3 CustomRectangle widgets in a Row
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the row
                    children: [
                      // Use Expanded to make each rectangle take equal width
                      Expanded(
                        child: CustomRectangle(
                          text: "Custom Rectangle 1",
                          icon: Icon(Icons.thumb_up, color: Colors.white),
                          number: 100,
                        ),
                      ),
                      SizedBox(width: 10), // Space between CustomRectangles

                      Expanded(
                        child: CustomRectangle(
                          text: "Custom Rectangle 2",
                          icon: Icon(Icons.star, color: Colors.white),
                          number: 200,
                        ),
                      ),
                      SizedBox(width: 10), // Space between CustomRectangles
                      Expanded(
                        child: CustomRectangle(
                          text: "Custom Rectangle 3",
                          icon: Icon(Icons.favorite, color: Colors.white),
                          number: 300,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20), // Add space after Custom Rectangles

                  // Button to navigate to People List
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the PeopleListScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PeopleListScreen(collectionName: 'nobs'),
                        ),
                      );
                    },
                    child: Text('Show People List'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
