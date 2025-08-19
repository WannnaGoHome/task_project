// ignore_for_file: avoid_print

import 'package:practise/data/api/number_api.dart';
import 'package:injectable/injectable.dart';

// lib/domain/repositories/number_repository.dart
abstract class NumberRepository {
  Future<String?> fetchMathFact(int number);
  Future<String?> fetchRandomTrivia();
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
}

// class NumberRepository
// {
//   final numberApi = NumberApi();

//   Future<String?> fetchMathFact(int number) async {
//     final endpoint = "$number/math";
//     try{
//       final response = await numberApi.get(endpoint);
//       if (response.statusCode == 200) {
//         return response.data.toString();
//       } else {
//         print("No Response");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//     return null;
//   }

//   Future<String?> fetchRandomTrivia() async {
//     const endpoint = "random/trivia";
//     try {
//       final response = await numberApi.get(endpoint);
//       if (response.statusCode == 200) {
//         return response.data.toString();
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//     return null;
// }

// }