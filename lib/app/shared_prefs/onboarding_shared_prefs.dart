import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/failure.dart';

class OnboardingSharedPrefs {
  final SharedPreferences _sharedPreferences;

  OnboardingSharedPrefs(this._sharedPreferences);

  Future<Either<Failure, void>> saveFirstTime() async {
    try {
      await _sharedPreferences.setBool('firstTimeInit', false);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> getFirstTime() async {
    try {
      final firstTime = _sharedPreferences.getBool('firstTimeInit');
      return Right(firstTime ?? true);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
