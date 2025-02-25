part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SignUpWithEmailAndPasswordEvent extends SignUpEvent {
  final String email;
  final String password;
  final String name;

  SignUpWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
    required this.name,
  });
  @override
  List<Object?> get props => [email, password, name];
}

final class SignUpWithGoogleEvent extends SignUpEvent {
  @override
  List<Object?> get props => [];
}

final class SignUpWithAppleEvent extends SignUpEvent {
  @override
  List<Object?> get props => [];
}
