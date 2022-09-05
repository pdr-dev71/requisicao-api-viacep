import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _recoverCep() async {
    String urlApi = 'https://viacep.com.br/ws/64655000/json/';
    http.Response response;

    response = await http.get(Uri.parse(urlApi));

    Map<String, dynamic> responseObj = jsonDecode(response.body);

    String cep = responseObj['cep'];
    String logradouro = responseObj['logradouro'];
    String uf = responseObj['uf'];

    print('Os dados são: Cep:$cep, Logradouro: $logradouro e UF: $uf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Consumo de api'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: _recoverCep,
              child: const Text('Recuperar Cep'),
            )
          ],
        ));
  }
}
