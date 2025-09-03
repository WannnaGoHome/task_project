

import 'package:practise/data/api/number_api.dart';
import 'package:injectable/injectable.dart';

abstract class NumberRepository {
  Future<String?> fetchMathFact(int number);
  Future<String?> fetchRandomTrivia();
  Future<String?> getServerError();
}
 
@Injectable(as: NumberRepository)
class NumberRepositoryImpl implements NumberRepository {
  final NumberApi _numberApi;

  NumberRepositoryImpl(this._numberApi);

  @override
  Future<String?> fetchMathFact(int number) async {
    try {
      return await _numberApi.getMathFact(number);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<String?> fetchRandomTrivia() async {
    try {
      return await _numberApi.getRandomTrivia();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<String?> getServerError() async {
    try {
      return await _numberApi.getServerError();
    } catch (_) {
      return null;
    }
  }


}