import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tourguard/core/error/exception.dart';
import 'package:tourguard/features/auth/data/models/user_model.dart';


abstract interface class AuthDataSource {
  Future<UserModel> signUpWithEmailAndPassword({required String email, required String password, required String name});

  Future<UserModel> signInWithEmailAndPassword({required String email, required String password});

  Future<UserModel> signUpWithGoogle();

  Future<UserModel> signInWithGoogle();

  Future<UserModel> signUpWithApple();

  Future<UserModel> signInWithApple();

  Future<UserModel?> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> sendPasswordResetEmail({required String email});

  Future<void> deleteAccount();

  Future<void> updatePassword({required String newPassword});

  Future<void> updateEmail({required String newEmail});

  Future<UserModel> updateName({required String newName});

  Future<void> signOut();
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;

  AuthDataSourceImpl(this.firebaseAuth, this.firestore, this.googleSignIn);

  @override
  Future<UserModel> signUpWithEmailAndPassword({required String email, required String password, required String name}) async {
    try {
      /// Step 1: Create a new user with the provided email and password
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint('User created: ${userCredential.user}');

      /// Step 2: Send email verification
      await userCredential.user?.sendEmailVerification();
      debugPrint('Email verification sent');

      /// Step 3: Create UserModel instance
      UserModel userModel = UserModel(
        id: '',
        name: name,
        email: email,
        createdAt: DateTime.now(),
      );

      /// Step 4: Save user details to Firestore
      final userDocRef = await firestore.collection('users').add(userModel.toJson());
      userModel = userModel.copyWith(id: userDocRef.id);
      await userDocRef.set(userModel.toJson());
      debugPrint('User details saved to Firestore: ${userModel.toString()}');
      return userModel;
    } on FirebaseAuthException catch (e) {
      debugPrint('Authentication error: ${e.message}');
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      debugPrint('User signed in: ${userCredential.user}');

      final user = await firestore.collection('users').where('email', isEqualTo: email).get();
      debugPrint('User found: ${user.docs.first.data()}');

      return UserModel.fromJson(user.docs.first.data());
    } on FirebaseAuthException catch (e) {
      debugPrint('Authentication error: ${e}');
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithGoogle() async {
    try {
      /// Step 1: Trigger the Google Authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw ServerException('Google sign-in aborted');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      /// Step 2: Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      /// Step 3: Sign in to Firebase with the Google credential
      UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);

      debugPrint('User signed in: ${userCredential.user}');

      /// Step 4: Check if user is new and retrieve user information
      UserModel userModel;

      final email = userCredential.user?.email ?? 'No Email';

      /// Check if the user already exists in Firestore
      final userDoc = await firestore.collection('users').where('email', isEqualTo: email).get();

      if (userDoc.docs.isEmpty) {
        /// User does not exist, create a new UserModel instance
        userModel = UserModel(
          id: '',
          name: userCredential.user?.displayName ?? 'Guest',
          email: email,
          createdAt: DateTime.now(),
        );

        /// Save user details to Firestore
        final userDocRef = await firestore.collection('users').add(userModel.toJson());
        userModel = userModel.copyWith(id: userDocRef.id);
        await userDocRef.set(userModel.toJson());
        debugPrint('User details saved to Firestore: ${userModel.toString()}');

        return userModel;
      } else {
        /// User already exists, retrieve existing user data
        userModel = UserModel.fromJson(userDoc.docs.first.data());
        debugPrint('User retrieved from Firestore: ${userModel.toString()}');
        return userModel;
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Authentication error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      /// Step 1: Trigger the Google Authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw ServerException('Google sign-in aborted');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      /// Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      /// Sign in to Firebase with the Google credential
      UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
      debugPrint('User signed in: ${userCredential.user}');

      /// Safely get the user's email
      final String email = userCredential.user?.email ?? 'No Email';
      debugPrint('User email is: $email');

      /// Step 2: Check if the user already exists in Firestore using the email
      final userQuery = await firestore.collection('users').where('email', isEqualTo: email).get();

      UserModel userModel;

      if (userQuery.docs.isEmpty) {
        /// Step 3: User does not exist, create a new UserModel instance
        userModel = UserModel(
          id: '',
          name: userCredential.user?.displayName ?? 'No Name',
          email: email,
          createdAt: DateTime.now(),
        );

        /// Step 4: Save user details to Firestore
        final userDocRef = await firestore.collection('users').add(userModel.toJson());
        userModel = userModel.copyWith(id: userDocRef.id);
        await userDocRef.set(userModel.toJson());
        debugPrint('User details saved to Firestore: ${userModel.toString()}');
        return userModel;
      } else {
        /// Step 5: User already exists, retrieve existing user data
        userModel = UserModel.fromJson(userQuery.docs.first.data());
        debugPrint('User retrieved from Firestore: ${userModel.toString()}');
      }

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Authentication error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithApple() async {
    try {
      throw UnimplementedError();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signInWithApple() async {
    try {
      throw UnimplementedError();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      throw UnimplementedError();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      throw UnimplementedError();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      throw UnimplementedError();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      throw UnimplementedError();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateEmail({required String newEmail}) async {
    try {
      throw UnimplementedError();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> updateName({required String newName}) async {
    try {
      throw UnimplementedError();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updatePassword({required String newPassword}) async {
    try {
      throw UnimplementedError();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
