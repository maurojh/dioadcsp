import 'package:shared_preferences/shared_preferences.dart';

enum ChavesArmazenamento {keyNome}

class AppStorage {
  Future<void> setConfiguracoesNome(String nome) async {
    await _setString(ChavesArmazenamento.keyNome, nome);
  }

  Future<String> getConfiguracoesNome() async {
    return await _getString(ChavesArmazenamento.keyNome);
  }

  Future<void> _setString(chave, valor) async {
    SharedPreferences armazenamento = await SharedPreferences.getInstance();
    armazenamento.setString(chave, valor);
  }

  Future<String> _getString(chave) async {
    SharedPreferences armazenamento = await SharedPreferences.getInstance();
    return armazenamento.getString(chave) ?? '';
  }
}