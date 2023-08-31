abstract class LoginStat {}

class LoginInitialStat extends LoginStat {}

class LoginLoadingStat extends LoginStat {}

class LoginSuccessStat extends LoginStat {}

class LoginFaliureStat extends LoginStat {
  final String erorrMessage;
  LoginFaliureStat({required this.erorrMessage});
}
