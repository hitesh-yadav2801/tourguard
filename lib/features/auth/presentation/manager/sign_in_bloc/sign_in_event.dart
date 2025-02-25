part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInWithGoogle extends SignInEvent {
  @override
  List<Object?> get props => [];
}

class SignInWithEmailAndPassword extends SignInEvent {
  final String email;
  final String password;

  SignInWithEmailAndPassword({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignInWithApple extends SignInEvent {
  @override
  List<Object?> get props => [];
}
