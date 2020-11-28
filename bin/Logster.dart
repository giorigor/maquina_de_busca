import 'dart:io';

import 'Dispositivo.dart';
import 'Processo.dart';

class Logster {
  static int n = 0;
  static int tempo = 0;
  static void log(Dispositivo d, Processo p, String tipo) {
    var msg = n.toString() +
        ';' +
        tempo.toString() +
        ';' +
        tipo +
        ';' +
        d.nome +
        ';' +
        d.executando.toString() +
        ';' +
        d.fila.length.toString() +
        ';' +
        p.nome +
        '\n';
    if (!d.pool) {
      File('log2.csv').writeAsStringSync(msg, mode: FileMode.append);
      print(msg);
    }
  }

  static void cabecalho() {
    var msg = 'N;TEMPO;TIPO;DISPOSITIVO;EXECUTANDO;FILA;PROCESSO\n';
    File('log2.csv').writeAsStringSync(msg, mode: FileMode.append);
  }
}
