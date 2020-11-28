import 'dart:math';

import 'Logster.dart';
import 'Processo.dart';

class Dispositivo extends Comparable<Dispositivo> {
  String nome;
  int si;
  List filhos;
  bool pool;
  bool executando;
  double probabilidade;

  Processo proc;
  List fila;

  int countdown;

  Dispositivo(String n, int s, bool p, double pro) {
    nome = n;
    si = s;
    pool = p;
    executando = false;
    filhos = [];
    fila = [];
    proc = null;
    probabilidade = pro;
  }

  void insereFilho(Dispositivo d) {
    filhos.add(d);
  }

  void insereProcesso(Processo p) {
    fila.add(p);
  }

  void iniciar(Processo p) {
    proc = p;
    countdown = si;
    executando = true;
    p.iniciar(this);
    Logster.log(this, p, 'INI');
  }

  void executar() {
    if (proc == null && fila.isEmpty) return null;
    if (proc == null && fila.isNotEmpty) return proximoDaFila();
    Logster.log(this, proc, 'RUN');
    countdown--;
    if (countdown == 0) {
      finalizar();
    }
  }

  void finalizar() {
    Logster.log(this, proc, 'FIM');
    proc.removePai();
    redirecionarAtual();
    proc = null;
    executando = false;
    if (fila.isNotEmpty) proximoDaFila();
  }

  void redirecionarAtual() {
    if (filhos.length == 1) {
      filhos[0].insereProcesso(proc);
    } else {
      filhos.sort();
      var r = Random().nextDouble();
      var ok = true;
      var i = 0;
      var prob_acum = 0.0;
      do {
        var disp = filhos[i];
        prob_acum += disp.probabilidade;
        if (r < prob_acum) {
          disp.insereProcesso(proc);
          break;
        } else {
          i++;
        }
      } while (ok);
    }
  }

  @override
  int compareTo(Dispositivo d) => probabilidade.compareTo(d.probabilidade);

  void proximoDaFila() => iniciar(fila.removeLast());
}
