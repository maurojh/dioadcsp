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
  bool temaEscuro = false;
  TextEditingController controlaNome = TextEditingController();
  TextEditingController controlaAltura = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Configurações'),
        ),
        body: Container(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: controlaNome,
                  decoration: const InputDecoration(
                    label: Text('Nome:'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: controlaAltura,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Altura:'),
                  ),
                ),
              ),
              SwitchListTile(
                title: const Text('Receber notificações:'),
                value: receberPushNotification,
                onChanged: (bool valor) {
                  setState(() {
                    receberPushNotification = valor;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Tema escuro:'),
                value: temaEscuro,
                onChanged: (bool valor) {
                  setState(() {
                    temaEscuro = valor;
                  });
                },
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
