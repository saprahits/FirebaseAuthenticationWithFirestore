part of 'sign_in_bloc.dart';

/// Transforms the [events] stream along with a [transitionFn] function into
/// a `Stream<Transition>`.
/// This is [SignInEvent] event for [Bloc]
abstract class SignInEvent extends Equatable {
  const SignInEvent();
}

/// Transforms the [events] stream along with a [transitionFn] function into
/// a `Stream<Transition>`.
/// This is [SignIn] event for [Bloc]
class SignIn extends SignInEvent {
  String email;
  String password;

  SignIn({required this.password, required this.email});

  @override
  List<Object> get props => [password, email];

  @override
  String toString() => '';
}
