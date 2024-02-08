import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class PeliculaProvider extends ChangeNotifier {
  late Map<String, dynamic> jsonData;
  int numeroAnterior=0;

  Future<void> getPeliculasData() async {
    print (numeroAnterior);
    int random=Random().nextInt(5000);
    print(random);
    if (numeroAnterior == random){
      print("repetido");
      random=Random().nextInt(5000);
    }
    String id=random.toString();
    String _baseUrl = "https://apoapi.onrender.com/v1/lapeli/$id";
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      numeroAnterior=random;
      String body = utf8.decode(response.bodyBytes);
      jsonData = json.decode(response.body);
      notifyListeners();
    } else {
      throw Exception("error");
    }

  }

  String obtenerURLIMagen(){
    return jsonData["data"]["poster_path"]??"";
  }
  String obtenerTitulo(){
    return jsonData["data"]["original_title"]??"";
  }
}
