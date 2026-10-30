import 'direccion.dart';
import 'estado_juego.dart';
import 'grid.dart';

class MotorJuego {
  Grid grid = Grid.vacio();
  int puntaje = 0;
  EstadoJuego estado = EstadoJuego.jugando;

  static const int objetivoVictoria = 2048;

  MotorJuego() {
    grid.agregarFichaAleatoria();
    grid.agregarFichaAleatoria();
  }

  void mover(Direccion direccion) {
    if (estado != EstadoJuego.jugando) return;

    final antes = grid.celdas.map((f) => List<int?>.from(f)).toList();

    final int puntosGanados = switch (direccion) {
      Direccion.izquierda => grid.moverIzquierda(),
      Direccion.derecha => grid.moverDerecha(),
      Direccion.arriba => grid.moverArriba(),
      Direccion.abajo => grid.moverAbajo(),
    };
    puntaje += puntosGanados;

    if (grid.haGanado(objetivoVictoria)) {
      estado = EstadoJuego.ganado;
      return;
    }

    final huboMovimiento = !_gridsIguales(antes, grid.celdas);
    if (huboMovimiento) {
      grid.agregarFichaAleatoria();
    }

    if (!grid.hayMovimientosPosibles()) {
      estado = EstadoJuego.perdido;
    }
  }

  bool _gridsIguales(List<List<int?>> a, List<List<int?>> b) {
    for (var f = 0; f < a.length; f++) {
      for (var c = 0; c < a[f].length; c++) {
        if (a[f][c] != b[f][c]) return false;
      }
    }
    return true;
  }
}
