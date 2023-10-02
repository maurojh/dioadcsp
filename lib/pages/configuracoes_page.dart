import 'package:flutter/material.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  String? nomeUsuario;
  double? altura;
  bool receberPushNotification = false;
  bool temaEscura = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Configurações'),
        ),
        body: Container(
          child: ListView(
            children: [
              SwitchListTile(
                title: Text('Receber notificações:'),
                value: receberPushNotification, onChanged: (bool valor) {
                setState(() {
                  receberPushNotification = valor;
                });
              },)
            ],
          ),
        ),
      ),
    );
  }
}
