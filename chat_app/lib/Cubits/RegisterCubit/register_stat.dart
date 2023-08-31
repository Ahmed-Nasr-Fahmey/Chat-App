abstract class RegisterStat {}

class RegisterInitialStat extends RegisterStat {}

class RegisterLoadingStat extends RegisterStat {}

class RegisterSuccessStat extends RegisterStat {}

class RegisterFaliureStat extends RegisterStat {
  final String erorrMessage;
  RegisterFaliureStat({required this.erorrMessage});
}
