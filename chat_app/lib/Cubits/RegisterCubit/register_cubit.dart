import 'package:chat_app/Cubits/RegisterCubit/register_stat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStat> {
  RegisterCubit() : super(RegisterInitialStat());

  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoadingStat());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccessStat());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFaliureStat(
          erorrMessage: 'Weak Password',
        ));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFaliureStat(
          erorrMessage: 'Email already exist',
        ));
      }
    } catch (e) {
      emit(RegisterFaliureStat(
        erorrMessage: 'There is an Erorr',
      ));
    }
  }
}
