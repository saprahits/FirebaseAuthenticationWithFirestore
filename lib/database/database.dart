import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

///  * [FirebaseAuth], which is used to CollectionReference of registerUser
final CollectionReference _userCollection =
    FirebaseFirestore.instance.collection('registerUser');

///  * [FirebaseAuth], which is used to CollectionReference of userLocation
final CollectionReference _locationCollection =
    FirebaseFirestore.instance.collection('userLocation');

///  * This Future use main Database
///  * [FirebaseAuth], which is used to manage the Firebase Auth user.
///  * [Database], which is used to manage the cloud firestore
class Database {
  static String? uid;

  ///  * This Future use for add User Data
  ///  * [FirebaseAuth], which is used to manage the Firebase Auth user.
  ///  * [name], which provides email
  ///  * [email], which provides email
  ///  * [Database], which is used to manage the cloud firestore
  static Future<void> addUserData(
      {required BuildContext context,
      required String name,
      required String email}) async {
    DocumentReference documentReferencer = _userCollection.doc(uid);
    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "email": email,
    };

    await documentReferencer.set(data).whenComplete(() => {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green,
              content: Text('User added to database')))
        });
  }

  ///  * This Future use for add Location,
  ///  * [FirebaseAuth], which is used to manage the Firebase Auth user.
  ///  * [location], which provides location
  ///  * [Database], which is used to manage the cloud firestore
  static Future<void> addLocation(
      {required BuildContext context, required String location}) async {
    Map<String, dynamic> data = <String, dynamic>{
      "location": location,
    };

    await _locationCollection.add(data).whenComplete(() => {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Location added to database')))
        });
  }

  ///  * This Future use for get All User,
  ///  * [FirebaseAuth], which is used to manage the Firebase Auth user.
  ///  * [QuerySnapshot], which provides QuerySnapshot
  ///  * [Database], which is used to manage the cloud firestore
  static Stream<QuerySnapshot> getAllUser() {
    return _userCollection.snapshots();
  }

  ///  * This Future use for get get All Locations
  ///  * [FirebaseAuth], which is used to manage the Firebase Auth user.
  ///  * [QuerySnapshot], which provides QuerySnapshot
  ///  * [Database], which is used to manage the cloud firestore
  static Stream<QuerySnapshot> getAllLocations() {
    return _locationCollection.snapshots();
  }

  ///  * This Future use for get delete User
  ///  * [FirebaseAuth], which is used to manage the Firebase Auth user.
  ///  * [userId], which provides userId
  ///  * [Database], which is used to manage the cloud firestore
  static Future<void> deleteUser({
    required BuildContext context,
    required String userId,
  }) async {
    await _userCollection
        .doc(userId)
        .delete()
        .whenComplete(() => {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('You have successfully deleted a user')))
            })
        .catchError((e) {
      //Todo:error
    });
  }
}
