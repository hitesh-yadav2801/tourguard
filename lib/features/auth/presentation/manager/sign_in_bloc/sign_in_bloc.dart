import 'dart:async';

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguard/core/usecase/usecase.dart';
import 'package:tourguard/features/auth/domain/entities/user.dart';
import 'package:tourguard/features/auth/domain/use_cases/sign_in_with_apple_use_case.dart';
import 'package:tourguard/features/auth/domain/use_cases/sign_in_with_email_password_use_case.dart';
import 'package:tourguard/features/auth/domain/use_cases/sign_in_with_google_use_case.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInWithEmailAndPasswordUseCase _signInWithEmailAndPasswordUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInWithAppleUseCase _signInWithAppleUseCase;

  SignInBloc({
    required SignInWithEmailAndPasswordUseCase signInWithEmailAndPasswordUseCase,
    required SignInWithGoogleUseCase signInWithGoogleUseCase,
    required SignInWithAppleUseCase signInWithAppleUseCase,
  })  : _signInWithEmailAndPasswordUseCase = signInWithEmailAndPasswordUseCase,
        _signInWithGoogleUseCase = signInWithGoogleUseCase,
        _signInWithAppleUseCase = signInWithAppleUseCase,
        super(SignInInitialState()) {
    on<SignInEvent>((event, emit) => emit(SignInLoadingState()));
    on<SignInWithEmailAndPassword>(_onSignInWithEmailAndPassword);
    on<SignInWithGoogle>(_onSignInWithGoogle);
    on<SignInWithApple>(_onSignInWithApple);
  }

  FutureOr<void> _onSignInWithEmailAndPassword(SignInWithEmailAndPassword event, Emitter<SignInState> emit) async {
    final result = await _signInWithEmailAndPasswordUseCase(SignInParams(email: event.email, password: event.password));
    result.fold(
      (l) => emit(SignInErrorState(message: l.message)),
      (r) => emit(SignInSuccessState(user: r)),
    );
  }

  FutureOr<void> _onSignInWithGoogle(SignInWithGoogle event, Emitter<SignInState> emit) async {
    final result = await _signInWithGoogleUseCase(NoParams());
    result.fold(
      (l) => emit(SignInErrorState(message: l.message)),
      (r) => emit(SignInSuccessState(user: r)),
    );
  }

  FutureOr<void> _onSignInWithApple(SignInWithApple event, Emitter<SignInState> emit) async {
    final result = await _signInWithAppleUseCase(NoParams());
    result.fold(
      (l) => emit(SignInErrorState(message: l.message)),
      (r) => emit(SignInSuccessState(user: r)),
    );
  }
}
