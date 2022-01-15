import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

/// {@template bloc} `SignInBloc`
/// Takes a `Stream` of `Events` as input --> SignInEvent
/// and transforms them into a `Stream` of `States` as output. --> SignInState
/// {@endtemplate}
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  FirebaseAuth? _auth;

  SignInBloc() : super(SignInInitial()) {
    _auth = FirebaseAuth.instance;
  }

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignIn) {
      yield* _mapSignInToState(event);
    }
  }

  /// {@use} : This Function use for SignInState API Event data
  /// {@param} :
  /// email, password
  Stream<SignInState> _mapSignInToState(SignIn event) async* {
    try {
      yield const SignInLoading();

      final User user = (await _auth!.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      ))
          .user!;
      if (user.uid.isNotEmpty) {
        yield SignInLoadSuccess(mUser: user);
      } else {
        yield const SignInFailure(error: '');
      }
    } catch (error) {
      yield const SignInFailure(error: '');
    }
  }
}
