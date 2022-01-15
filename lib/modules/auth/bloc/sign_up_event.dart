part of 'sign_up_bloc.dart';

/// Transforms the [events] stream along with a [transitionFn] function into
/// a `Stream<Transition>`.
/// This is [SignUpEvent] event for [Bloc]
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

/// Transforms the [events] stream along with a [transitionFn] function into
/// a `Stream<Transition>`.
/// This is [SignUp] event for [Bloc]
class SignUp extends SignUpEvent {
  String email;
  String password;

  SignUp({required this.password, required this.email});

  @override
  List<Object> get props => [password, email];

  @override
  String toString() => '';
}
