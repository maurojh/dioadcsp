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
    setState(() {
      controlaNome.text = armazenamento.getString(KEY_NOME) ?? '';
      controlaAltura.text =
          (armazenamento.getDouble(KEY_ALTURA) ?? 0).toString();
      temaEscuro = armazenamento.getBool(KEY_MODO) ?? false;
      receberPushNotification =
          armazenamento.getBool(KEY_NOTIFICACOES) ?? false;
    });
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
                  FocusManager.instance.primaryFocus?.unfocus();
                  try {
                    await armazenamento.setDouble(
                        KEY_ALTURA, double.parse(controlaAltura.text));
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (_) {
                        AlertDialog(
                          title: Text('Configurações'),
                          content: Text('Favor digitar uma altura válida!'),
                          actions: [
                            TextButton(onPressed: () {}, child: Text('Salvar'),),
                          ],
                        );
                      },
                    );
                  }
                  await armazenamento.setBool(KEY_MODO, temaEscuro);
                  await armazenamento.setBool(
                      KEY_NOTIFICACOES, receberPushNotification);
                  await armazenamento.setString(KEY_NOME, controlaNome.text);
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
