import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tourguard/features/auth/data/data_sources/auth_data_source.dart';
import 'package:tourguard/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tourguard/features/auth/domain/repositories/auth_repository.dart';
import 'package:tourguard/features/auth/domain/use_cases/sign_in_with_apple_use_case.dart';
import 'package:tourguard/features/auth/domain/use_cases/sign_in_with_email_password_use_case.dart';
import 'package:tourguard/features/auth/domain/use_cases/sign_in_with_google_use_case.dart';
import 'package:tourguard/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:tourguard/features/auth/domain/use_cases/sign_up_with_apple_use_case.dart';
import 'package:tourguard/features/auth/domain/use_cases/sign_up_with_email_password_use_case.dart';
import 'package:tourguard/features/auth/domain/use_cases/sign_up_with_google_use_case.dart';
import 'package:tourguard/features/auth/presentation/manager/sign_in_bloc/sign_in_bloc.dart';
import 'package:tourguard/features/auth/presentation/manager/sign_up_bloc/sign_up_bloc.dart';



part 'dependency_injection.dart';
