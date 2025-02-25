import 'package:fpdart/fpdart.dart';
import 'package:tourguard/core/error/failure.dart';
import 'package:tourguard/core/usecase/usecase.dart';
import 'package:tourguard/features/auth/domain/entities/user.dart';
import 'package:tourguard/features/auth/domain/repositories/auth_repository.dart';

class SignUpWithEmailAndPasswordUseCase implements UseCase<User, SignUpParams> {
  final AuthRepository authRepository;

  SignUpWithEmailAndPasswordUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await authRepository.signUpWithEmailAndPassword(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String name;

  SignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
