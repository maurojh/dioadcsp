import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late SharedPreferences armazenamento;
  final KEY_NOME = 'nome';
  final KEY_ALTURA = 'altura';
  final KEY_MODO = 'modo';
  final KEY_NOTIFICACOES = 'noficacoes';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    armazenamento = await SharedPreferences.getInstance();
  }

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
                onPressed: () async {
                  await armazenamento.setBool(KEY_MODO, temaEscuro);
                  await armazenamento.setBool(KEY_NOTIFICACOES, receberPushNotification);
                  await armazenamento.setString(KEY_NOME, controlaNome.text);
                  await armazenamento.setDouble(KEY_ALTURA, double.tryParse(controlaAltura.text) ?? 0);
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
