import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_stat.dart';

class LoginCubit extends Cubit<LoginStat> {
  LoginCubit() : super(LoginInitialStat());

  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoadingStat());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccessStat());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFaliureStat(
          erorrMessage: 'No user found for that email.',
        ));
      } else if (e.code == 'wrong-password') {
        emit(LoginFaliureStat(
          erorrMessage: 'Wrong password provided for that user.',
        ));
      }
    } catch (e) {
      emit(LoginFaliureStat(
        erorrMessage: 'There is an Erorr',
      ));
    }
  }
}
