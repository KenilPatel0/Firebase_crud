import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DataBase {
  Future<void> userDetails(Map<String, dynamic> userInfoMap, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("Data")
          .doc(id)
          .set(userInfoMap);
    } catch (e) {
      print("Error adding user details: $e");
      rethrow;
    }
  }

  Future<Stream<QuerySnapshot>?> getData() async {
    try {
      return FirebaseFirestore.instance.collection('Data').snapshots();
    } catch (e) {
      print("Error getting data: $e");
      if (kIsWeb) {
        print(
            "Running on the web, make sure Firebase is properly initialized.");
      }
      return null; // Return null in case of an error
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await FirebaseFirestore.instance.collection('Data').doc(id).delete();
    } catch (e) {
      print("Error deleting user: $e");
      rethrow;
    }
  }

  Future<void> updateUser(String id, Map<String, dynamic> userInfoMap) async {
    try {
      await FirebaseFirestore.instance
          .collection('Data')
          .doc(id)
          .update(userInfoMap);
    } catch (e) {
      print("Error updating user: $e");
      rethrow;
    }
  }
}
