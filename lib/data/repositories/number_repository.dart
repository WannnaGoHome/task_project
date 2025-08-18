// ignore_for_file: avoid_print

import 'package:practise/data/api/number_api.dart';
import 'package:dio/dio.dart';

class NumberRepository {
  final numberApi = NumberApi(Dio());

  Future<String?> fetchMathFact(int number) async {
    try {
      final fact = await numberApi.getMathFact(number);
      return fact;
    }
    catch (_){
      return null;
    }
  }

  Future<String?> fetchRandomTrivia() async {
    try {
      return await numberApi.getRandomTrivia();
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