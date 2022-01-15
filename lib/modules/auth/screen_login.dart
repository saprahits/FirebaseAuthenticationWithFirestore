import 'package:demo/modules/auth/bloc/sign_in_bloc.dart';
import 'package:demo/utils/app_routes.dart';
import 'package:demo/utils/app_string.dart';
import 'package:demo/utils/multi_value_listenable_builder.dart';
import 'package:demo/utils/navigator_key.dart';
import 'package:demo/utils/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///  * This Class use for Screen Login
///  * [Scaffold], which provides standard app elements like an [AppBar] and a [Drawer].
///  * [Form], which provides Form page.
///  * [TextEditingController], which provides Text Editor.
///  * [FirebaseAuth], which is used to manage the Firebase Auth user.
///  * [Navigator], which is used to manage the app's stack of pages.
class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  _ScreenLoginState createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  ValueNotifier<bool> mLoading = ValueNotifier<bool>(false);

  User? user;

  @override
  void initState() {
    _auth.userChanges().listen(
      (currentUser) {
        if (currentUser != null) {
          setState(() => user = currentUser);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiValueListenableBuider(
        valueListenAbles: [mLoading],
        builder: (BuildContext context, values, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(AppString.textSignIn),
            ),
            body: BlocListener<SignInBloc, SignInState>(
              listener: (context, state) {
                if (state is SignInLoading) {
                  mLoading.value = true;
                } else {
                  mLoading.value = false;
                }
                if (state is SignInLoadSuccess) {
                  final User user = state.mUser;
                  NavigatorKey.navigatorKey.currentState!
                      .pushNamedAndRemoveUntil(
                          AppRoutes.routesHome, (route) => false);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content:
                          Text('${user.email} ' + AppString.textSignedIn)));
                }
                if (state is SignInFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(AppString.textSignInFail)));
                }
              },
              child: Form(
                key: _formKey,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            AppString.textSignWithEmail,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                              labelText: AppString.textEmail),
                          validator: (value) =>
                              Validator.validateEmail(email: value!),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                              labelText: AppString.textPassword),
                          validator: (value) =>
                              Validator.validatePassword(password: value!),
                          obscureText: true,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 16),
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate() &&
                                  mLoading.value == false) {
                                BlocProvider.of<SignInBloc>(context).add(SignIn(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ));
                              }
                            },
                            child: mLoading.value
                                ? const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.pink),
                                        backgroundColor: Colors.transparent),
                                  )
                                : const Text(AppString.textSignIn),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 16),
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (mLoading.value == false) {
                                NavigatorKey.navigatorKey.currentState!
                                    .pushNamed(AppRoutes.routesRegister);
                              }
                            },
                            child: const Text(AppString.textSignUp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
