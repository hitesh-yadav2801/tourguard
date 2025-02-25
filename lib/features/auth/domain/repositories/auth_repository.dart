import 'package:fpdart/fpdart.dart';
import 'package:tourguard/core/error/failure.dart';
import 'package:tourguard/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailAndPassword({required String email, required String password, required String name});
  Future<Either<Failure, User>> signInWithEmailAndPassword({required String email, required String password});
  Future<Either<Failure, User>> signUpWithGoogle();
  Future<Either<Failure, User>> signInWithGoogle();
  Future<Either<Failure, User>> signUpWithApple();
  Future<Either<Failure, User>> signInWithApple();
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, void>> sendEmailVerification();
  Future<Either<Failure, void>> sendPasswordResetEmail({required String email});
  Future<Either<Failure, void>> deleteAccount();
  Future<Either<Failure, void>> updatePassword({required String newPassword});
  Future<Either<Failure, void>> updateEmail({required String newEmail});
  Future<Either<Failure, User>> updateName({required String newName});
  Future<Either<Failure, void>> signOut();
}
