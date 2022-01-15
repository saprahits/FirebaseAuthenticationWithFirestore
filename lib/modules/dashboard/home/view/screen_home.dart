import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/database/database.dart';
import 'package:demo/utils/app_routes.dart';
import 'package:demo/utils/app_string.dart';
import 'package:demo/utils/navigator_key.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.appName),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                NavigatorKey.navigatorKey.currentState!.pushNamedAndRemoveUntil(
                    AppRoutes.routesSplash, (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: Database.getAllUser(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final String item =
                          streamSnapshot.data!.docs[index].toString();
                      DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      user = _auth.currentUser!;
                      return Dismissible(
                        key: Key(item),
                        direction: user.uid != documentSnapshot.id
                            ? DismissDirection.endToStart
                            : DismissDirection.none,
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            setState(() {
                              Database.deleteUser(
                                  context: context,
                                  userId: documentSnapshot.id);
                            });
                          }
                        },
                        background: Container(
                          color: Colors.redAccent,
                          width: double.infinity,
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                AppString.textSwipeToDelete,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => {}),
                            ],
                          ),
                        ),
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(documentSnapshot['name']),
                            trailing: user.uid != documentSnapshot.id
                                ? const SizedBox()
                                : const Text(AppString.textCurrent),
                            subtitle:
                                Text(documentSnapshot['email'].toString()),
                            onTap: () {
                              user = _auth.currentUser!;
                            },
                          ),
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
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 26),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                NavigatorKey.navigatorKey.currentState!
                    .pushNamed(AppRoutes.routesAddLocation);
              },
              child: const Text(AppString.textAddLocation),
            ),
          ),
        ],
      ),
      // Add new product
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
