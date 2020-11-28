import 'Dispositivo.dart';

class Processo {
  String nome;
  Dispositivo disp;

  Processo(String n) {
    nome = n;
  }

  void removePai() {
    disp = null;
  }

  void iniciar(Dispositivo d) {
    disp = d;
  }
}
