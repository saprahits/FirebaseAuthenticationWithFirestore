part of 'sign_up_bloc.dart';

/// Updates the state of the bloc to the provided [state].
/// A bloc's state should only be updated by `emitting` a new `state`
/// from an [SignUpState] in response to an incoming event.
abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

/// Updates the state of the bloc to the provided [state].
/// A bloc's state should only be updated by `emitting` a new `state`
/// from an [SignUpInitial] in response to an incoming event.
class SignUpInitial extends SignUpState {}

/// Updates the state of the bloc to the provided [state].
/// A bloc's state should only be updated by `emitting` a new `state`
/// from an [SignUpLoading] in response to an incoming event.
class SignUpLoading extends SignUpState {
  const SignUpLoading();

  @override
  List<Object> get props => [];
}

/// Updates the state of the bloc to the provided [state].
/// A bloc's state should only be updated by `emitting` a new `state`
/// from an [SignUpLoadSuccess] in response to an incoming event.
class SignUpLoadSuccess extends SignUpState {
  User mUser;

  SignUpLoadSuccess({
    required this.mUser,
  });

  @override
  List<Object> get props => [mUser];
}

/// Updates the state of the bloc to the provided [state].
/// A bloc's state should only be updated by `emitting` a new `state`
/// from an [SignUpFailure] in response to an incoming event.
class SignUpFailure extends SignUpState {
  final String error;

  const SignUpFailure({required this.error});

  @override
  List<Object> get props => [error];
}
