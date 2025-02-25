part of 'sign_in_bloc.dart';

@immutable
sealed class SignInState extends Equatable {}

final class SignInInitialState extends SignInState {
  @override
  List<Object?> get props => [];
}

final class SignInLoadingState extends SignInState {
  @override
  List<Object?> get props => [];
}

final class SignInSuccessState extends SignInState {
  final User user;

  SignInSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}

final class SignInErrorState extends SignInState {
  final String message;

  SignInErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
