import 'package:demo/modules/auth/bloc/sign_in_bloc.dart';
import 'package:demo/modules/auth/bloc/sign_up_bloc.dart';
import 'package:demo/modules/splash/view/screen_splash.dart';
import 'package:demo/utils/app_routes.dart';
import 'package:demo/utils/app_string.dart';
import 'package:demo/utils/navigator_key.dart';
import 'package:demo/utils/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

/// Creates a main for start app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

/// Creates a MyApp for run app.
/// This callback which will be called when [Provider] is unmounted from the
/// creating the [Bloc] or [Cubit] and a [child] which will have access
/// widget tree.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          BlocProvider<SignInBloc>(
              create: (BuildContext context) => SignInBloc()),
          BlocProvider<SignUpBloc>(
              create: (BuildContext context) => SignUpBloc())
        ],
        child: MaterialApp(
          title: AppString.appName,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: AppRoutes.routesSplash,
          home: const ScreenSplash(),
          navigatorKey: NavigatorKey.navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
          debugShowCheckedModeBanner: false,
        ));
  }
}
