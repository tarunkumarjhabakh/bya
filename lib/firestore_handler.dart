import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addData() async {
  // Get Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Add a new document in the 'users' collection
  await firestore.collection('users').add({
    'name': 'John Doe',
    'age': 25,
    'email': 'john.doe@example.com',
  });
}

Future<List<Map<String, dynamic>>> getData(String collectionName) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> dataList = [];

  try {
    // Fetch all documents from the specified collection
    QuerySnapshot snapshot = await firestore.collection(collectionName).get();

    // Iterate through the documents and add data to the list
    for (var doc in snapshot.docs) {
      dataList.add(doc.data() as Map<String, dynamic>);
    }
  } catch (e) {
    print("Error fetching data: $e");
  }

  return dataList;
}
