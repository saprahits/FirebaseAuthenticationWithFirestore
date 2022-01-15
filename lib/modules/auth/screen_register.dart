import 'package:demo/database/database.dart';
import 'package:demo/modules/auth/bloc/sign_up_bloc.dart';
import 'package:demo/utils/app_routes.dart';
import 'package:demo/utils/app_string.dart';
import 'package:demo/utils/multi_value_listenable_builder.dart';
import 'package:demo/utils/navigator_key.dart';
import 'package:demo/utils/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///  * This Class use for Screen Register
///  * [Scaffold], which provides standard app elements like an [AppBar] and a [Drawer].
///  * [Form], which provides Form page.
///  * [TextEditingController], which provides Text Editor.
///  * [FirebaseAuth], which is used to manage the Firebase Auth user.
///  * [Database], which is used to manage the cloud firestore
///  * [Navigator], which is used to manage the app's stack of pages.
class ScreenRegister extends StatefulWidget {
  const ScreenRegister({Key? key}) : super(key: key);

  @override
  _ScreenRegisterState createState() => _ScreenRegisterState();
}

class _ScreenRegisterState extends State<ScreenRegister> {
  ValueNotifier<bool> mLoading = ValueNotifier<bool>(false);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _userEmail = '';

  @override
  Widget build(BuildContext context) {
    return MultiValueListenableBuider(
        valueListenAbles: [mLoading],
        builder: (BuildContext context, values, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(AppString.textSignUp),
            ),
            body: BlocListener<SignUpBloc, SignUpState>(
              listener: (context, state) {
                if (state is SignUpLoading) {
                  mLoading.value = true;
                } else {
                  mLoading.value = false;
                }
                if (state is SignUpLoadSuccess) {
                  _register(state.mUser);
                }

                if (state is SignUpFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(state.error)));
                }
              },
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            labelText: AppString.textName),
                        validator: (value) =>
                            Validator.validateName(name: value!),
                      ),
                      TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                              labelText: AppString.textEmail),
                          validator: (value) =>
                              Validator.validateEmail(email: value!)),
                      TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: AppString.textPassword),
                          validator: (value) =>
                              Validator.validatePassword(password: value!)),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate() &&
                                mLoading.value == false) {
                              BlocProvider.of<SignUpBloc>(context).add(SignUp(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ));
                            }
                          },
                          child: mLoading.value
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.pink),
                                      backgroundColor: Colors.transparent),
                                )
                              : const Text(AppString.textSubmit),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  ///  * This Future use for user register ,
  ///  * [FirebaseAuth], which is used to manage the Firebase Auth user.
  ///  * [ScaffoldMessenger], which provides Scaffold Messenger
  ///  * [Database], which is used to manage the cloud firestore
  void _register(User mUser) async {
    try {
      User? user = mUser;
      if (user.uid.isNotEmpty) {
        setState(() {
          _userEmail = user.email!;
          Database.uid = user.uid;
        });
      }
      await Database.addUserData(
          context: context, name: _nameController.text, email: _userEmail);
      NavigatorKey.navigatorKey.currentState!
          .pushNamedAndRemoveUntil(AppRoutes.routesHome, (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(AppString.textSomethingWentWrong)));
    }
  }
}
