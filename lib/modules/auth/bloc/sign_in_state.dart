part of 'sign_in_bloc.dart';

/// Updates the state of the bloc to the provided [state].
/// A bloc's state should only be updated by `emitting` a new `state`
/// from an [SignInState] in response to an incoming event.
abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

/// Updates the state of the bloc to the provided [state].
/// A bloc's state should only be updated by `emitting` a new `state`
/// from an [SignInInitial] in response to an incoming event.
class SignInInitial extends SignInState {}

/// Updates the state of the bloc to the provided [state].
/// A bloc's state should only be updated by `emitting` a new `state`
/// from an [SignInLoading] in response to an incoming event.
class SignInLoading extends SignInState {
  const SignInLoading();

  @override
  List<Object> get props => [];
}

/// Updates the state of the bloc to the provided [state].
/// A bloc's state should only be updated by `emitting` a new `state`
/// from an [SignInLoadSuccess] in response to an incoming event.
class SignInLoadSuccess extends SignInState {
  User mUser;

  SignInLoadSuccess({
    required this.mUser,
  });

  @override
  List<Object> get props => [mUser];
}

/// Updates the state of the bloc to the provided [state].
/// A bloc's state should only be updated by `emitting` a new `state`
/// from an [SignInFailure] in response to an incoming event.
class SignInFailure extends SignInState {
  final String error;

  const SignInFailure({required this.error});

  @override
  List<Object> get props => [error];
}
