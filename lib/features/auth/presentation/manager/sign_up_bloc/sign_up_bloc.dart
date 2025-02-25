import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguard/core/usecase/usecase.dart';
import 'package:tourguard/features/auth/domain/entities/user.dart';
import 'package:tourguard/features/auth/domain/use_cases/sign_up_with_apple_use_case.dart';
import 'package:tourguard/features/auth/domain/use_cases/sign_up_with_email_password_use_case.dart';
import 'package:tourguard/features/auth/domain/use_cases/sign_up_with_google_use_case.dart';


part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpWithEmailAndPasswordUseCase _signUpWithEmailAndPasswordUseCase;
  final SignUpWithGoogleUseCase _signUpWithGoogleUseCase;
  final SignUpWithAppleUseCase _signUpWithAppleUseCase;

  SignUpBloc({
    required SignUpWithEmailAndPasswordUseCase signUpWithEmailAndPasswordUseCase,
    required SignUpWithGoogleUseCase signUpWithGoogleUseCase,
    required SignUpWithAppleUseCase signUpWithAppleUseCase,
  })  : _signUpWithEmailAndPasswordUseCase = signUpWithEmailAndPasswordUseCase,
        _signUpWithGoogleUseCase = signUpWithGoogleUseCase,
        _signUpWithAppleUseCase = signUpWithAppleUseCase,
        super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) => emit(SignUpLoading()));
    on<SignUpWithEmailAndPasswordEvent>(_onSignUpWithEmailAndPassword);
    on<SignUpWithGoogleEvent>(_onSignUpWithGoogle);
    on<SignUpWithAppleEvent>(_onSignUpWithApple);
  }

  void _onSignUpWithEmailAndPassword(SignUpWithEmailAndPasswordEvent event, Emitter<SignUpState> emit) async {
    final result = await _signUpWithEmailAndPasswordUseCase(
      SignUpParams(email: event.email, password: event.password, name: event.name),
    );
    result.fold(
      (l) => emit(SignUpError(message: l.message)),
      (r) => emit(SignUpSuccess(user: r)),
    );
  }

  void _onSignUpWithGoogle(SignUpWithGoogleEvent event, Emitter<SignUpState> emit) async {
    final result = await _signUpWithGoogleUseCase(NoParams());
    result.fold(
      (l) => emit(SignUpError(message: l.message)),
      (r) => emit(SignUpSuccess(user: r)),
    );
  }

  void _onSignUpWithApple(SignUpWithAppleEvent event, Emitter<SignUpState> emit) async {
    final result = await _signUpWithAppleUseCase(NoParams());
    result.fold(
      (l) => emit(SignUpError(message: l.message)),
      (r) => emit(SignUpSuccess(user: r)),
    );
  }
}
