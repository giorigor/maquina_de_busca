import 'Dispositivo.dart';
import 'Logster.dart';
import 'Processo.dart';

void main(List<String> arguments) {
  Logster.cabecalho();
  for (var n = 0; n <= 20; n++) {
    Logster.tempo = 0;
    Logster.n = n;
    var dispositivos = [];
    var cpu = Dispositivo('CPU ', 15, false, 1.00);
    dispositivos.add(cpu);
    var d1 = Dispositivo('D1  ', 15, false, 0.45);
    dispositivos.add(d1);
    var d2 = Dispositivo('D2  ', 25, false, 0.15);
    dispositivos.add(d2);
    var d3 = Dispositivo('D3  ', 15, false, 0.30);
    dispositivos.add(d3);
    var pool = Dispositivo('POOL', 0, true, 0.10);
    dispositivos.add(pool);

    cpu.insereFilho(d1);
    cpu.insereFilho(d2);
    cpu.insereFilho(d3);
    cpu.insereFilho(pool);

    d1.insereFilho(pool);
    d2.insereFilho(pool);
    d3.insereFilho(pool);

    for (var i = 0; i < n * 10; i++) {
      var p_b = Dispositivo('subpool ' + i.toString(), 500, true, 1 / (n * 10));
      pool.insereFilho(p_b);
      p_b.insereFilho(cpu);
    }

    for (var i = 1; i <= n; i++) {
      cpu.insereProcesso(Processo('P' + i.toString()));
    }

    do {
      for (Dispositivo disp in dispositivos) {
        disp.executar();
      }
      Logster.tempo++;
    } while (Logster.tempo < 20000);
  }
}
