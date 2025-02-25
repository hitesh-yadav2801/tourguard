part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SignUpInitial extends SignUpState {
  @override
  List<Object?> get props => [];
}

final class SignUpLoading extends SignUpState {
  @override
  List<Object?> get props => [];
}

final class SignUpSuccess extends SignUpState {
  final User user;

  SignUpSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

final class SignUpError extends SignUpState {
  final String message;

  SignUpError({required this.message});

  @override
  List<Object?> get props => [message];
}
