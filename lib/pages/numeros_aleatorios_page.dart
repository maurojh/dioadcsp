import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumerosAleatoriosPage extends StatefulWidget {
  const NumerosAleatoriosPage({super.key});

  @override
  State<NumerosAleatoriosPage> createState() => _NumerosAleatoriosPageState();
}

class _NumerosAleatoriosPageState extends State<NumerosAleatoriosPage> {
  int numeroGerado = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    final armazenamento = await SharedPreferences.getInstance();
    var retorno = armazenamento.getInt('aleatorio');
    setState(() {
      if (retorno == null) {
        numeroGerado = 0;
      } else {
        numeroGerado = retorno;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gerador de números aleatórios'),
        ),
        body: Container(
          child: Column(
            children: [Text('$numeroGerado')],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              final armazenamento = await SharedPreferences.getInstance();
              var num = Random().nextInt(1000);
              setState(() {
                numeroGerado = num;
              });
              armazenamento.setInt('aleatorio', numeroGerado);
            }),
      ),
    );
  }
}
