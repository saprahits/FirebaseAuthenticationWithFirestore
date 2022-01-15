import 'package:demo/database/database.dart';
import 'package:demo/utils/app_routes.dart';
import 'package:demo/utils/app_string.dart';
import 'package:demo/utils/navigator_key.dart';
import 'package:demo/utils/validation_string.dart';
import 'package:flutter/material.dart';

///  * This Future use for Screen Add Location,
///  * [FirebaseAuth], which is used to manage the Firebase Auth user.
///  * [Navigator], which is used to manage the app's stack of pages.
class ScreenAddLocation extends StatefulWidget {
  const ScreenAddLocation({Key? key}) : super(key: key);

  @override
  _ScreenAddLocationState createState() => _ScreenAddLocationState();
}

class _ScreenAddLocationState extends State<ScreenAddLocation> {
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.textAddLocation),
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _locationController,
                decoration:
                    const InputDecoration(labelText: AppString.textLocation),
                validator: (String? value) {
                  if (value!.isEmpty)
                    return ValidationString.errorEnterSomeText;
                  return null;
                },
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    await Database.addLocation(
                        context: context, location: _locationController.text);
                    FocusScope.of(context).requestFocus(FocusNode());
                    _locationController.text = '';
                  },
                  child: const Text(AppString.textAddLocation),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    NavigatorKey.navigatorKey.currentState!
                        .pushNamed(AppRoutes.routesViewLocation);
                  },
                  child: const Text(AppString.textViewLocation),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
