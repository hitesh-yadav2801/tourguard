import 'package:fpdart/fpdart.dart';
import 'package:tourguard/core/error/exception.dart';
import 'package:tourguard/core/error/failure.dart';
import 'package:tourguard/features/auth/data/data_sources/auth_data_source.dart';
import 'package:tourguard/features/auth/domain/entities/user.dart';
import 'package:tourguard/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({required String email, required String password, required String name}) async {
    try {
      final user = await authDataSource.signUpWithEmailAndPassword(email: email, password: password, name: name);
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final user = await authDataSource.signInWithEmailAndPassword(email: email, password: password);
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithGoogle() async {
    try {
      final user = await authDataSource.signUpWithGoogle();
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      final user = await authDataSource.signInWithGoogle();
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithApple() async {
    try {
      final user = await authDataSource.signUpWithApple();
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithApple() async {
    try {
      final user = await authDataSource.signInWithApple();
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await authDataSource.getCurrentUser();
      if (user == null) {
        return Left(Failure('User not found'));
      }
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      return Right(await authDataSource.signOut());
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> sendEmailVerification() async {
    // TODO: implement sendEmailVerification
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail({required String email}) async {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateEmail({required String newEmail}) async {
    // TODO: implement updateEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> updateName({required String newName}) async {
    // TODO: implement updateName
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updatePassword({required String newPassword}) async {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }
}
