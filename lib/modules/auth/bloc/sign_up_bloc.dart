import 'dart:async';

import 'package:demo/utils/app_string.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

/// {@template bloc} `SignUpBloc`
/// Takes a `Stream` of `Events` as input --> SignUpEvent
/// and transforms them into a `Stream` of `States` as output. --> SignUpState
/// {@endtemplate}
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  FirebaseAuth? _auth;

  SignUpBloc() : super(SignUpInitial()) {
    _auth = FirebaseAuth.instance;
  }

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUp) {
      yield* _mapSignUpToState(event);
    }
  }

  /// {@use} : This Function use for SignUpState API Event data
  /// {@param} :
  /// email, password
  Stream<SignUpState> _mapSignUpToState(SignUp event) async* {
    yield const SignUpLoading();
    try {
      final User user = (await _auth!.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      ))
          .user!;
      yield SignUpLoadSuccess(mUser: user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        yield const SignUpFailure(error: AppString.textThePasswordTooWeak);
      } else if (e.code == 'email-already-in-use') {
        yield const SignUpFailure(error: AppString.textTheAccountAlreadyExists);
      }
    } catch (e) {
      yield const SignUpFailure(error: AppString.textSomethingWentWrong);
    }
  }
}
