import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  String _result = 'Resultado';
  _recoverCep() async {
    String cepInput = _controller.text;
    String urlApi = 'https://viacep.com.br/ws/$cepInput/json/';
    http.Response response;

    response = await http.get(Uri.parse(urlApi));

    Map<String, dynamic> responseObj = jsonDecode(response.body);

    String cep = responseObj['cep'];
    String logradouro = responseObj['logradouro'];
    String localidade = responseObj['localidade'];
    String uf = responseObj['uf'];
    String ddd = responseObj['ddd'];

    setState(() {
      _result = '$cep, $logradouro, $localidade, $uf, $ddd';
    });

    print('Os dados são: Cep:$cep, Logradouro: $localidade e UF: $uf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Consumo de api'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/search.png',
                    width: MediaQuery.of(context).size.width * .6,
                    height: MediaQuery.of(context).size.height * .2),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Texto não pode ser vazio';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Digite o cep, formato 00000000'),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _recoverCep();
                  }
                },
                child: const Text('Recuperar Cep'),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(_result),
                ),
              ),
            ],
          ),
        ));
  }
}
