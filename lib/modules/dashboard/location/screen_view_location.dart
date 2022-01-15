import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/database/database.dart';
import 'package:demo/utils/app_string.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

///  * This Future use for Screen View Location,
///  * [FirebaseAuth], which is used to manage the Firebase Auth user.
///  * [Database], which is used to manage Database
class ScreenViewLocation extends StatefulWidget {
  const ScreenViewLocation({Key? key}) : super(key: key);

  @override
  _ScreenViewLocationState createState() => _ScreenViewLocationState();
}

class _ScreenViewLocationState extends State<ScreenViewLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.textViewLocation),
      ),
      body: StreamBuilder(
        stream: Database.getAllLocations(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['location']),
                    onTap: () {
                      launchMap(documentSnapshot['location']);
                    },
                    trailing: SizedBox(width: 100, child: Container()),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void launchMap(String address) async {
    String query = Uri.encodeComponent(address);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";
    if (!await launch(
      googleUrl,
      forceSafariVC: true,
      forceWebView: true,
      enableJavaScript: true,
    )) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Could not launch $googleUrl')));
      throw 'Could not launch $googleUrl';
    }
  }
}
