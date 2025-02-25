import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(SessionInitial());
}
