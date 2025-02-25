import 'package:fpdart/fpdart.dart';
import 'package:tourguard/core/error/failure.dart';
import 'package:tourguard/core/usecase/usecase.dart';
import 'package:tourguard/features/auth/domain/entities/user.dart';
import 'package:tourguard/features/auth/domain/repositories/auth_repository.dart';

class SignInWithAppleUseCase implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  SignInWithAppleUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.signInWithApple();
  }
}