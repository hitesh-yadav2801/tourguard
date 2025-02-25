import 'package:fpdart/fpdart.dart';
import 'package:tourguard/core/error/failure.dart';
import 'package:tourguard/core/usecase/usecase.dart';
import 'package:tourguard/features/auth/domain/entities/user.dart';
import 'package:tourguard/features/auth/domain/repositories/auth_repository.dart';

class SignInWithEmailAndPasswordUseCase implements UseCase<User, SignInParams> {
  final AuthRepository authRepository;

  SignInWithEmailAndPasswordUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(SignInParams params) async {
    return await authRepository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}
