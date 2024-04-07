import 'dart:math';

class Numero {
  static List generarNumero(String dificultad) {
    var random = Random();
    switch (dificultad) {
      case 'Fácil':
        return [random.nextInt(10) + 1, '5'];
      case 'Medio':
        return [random.nextInt(20) + 1, '8'];
      case 'Avanzado':
        return [random.nextInt(100) + 1, '15'];
      case 'Extremo':
        return [random.nextInt(1000) + 1, '25'];
      default:
        return [random.nextInt(10) + 1, '5'];
    }
  }

  static String validarNumero(int numeroElegido, int numeroBuscado) {
    return numeroElegido > numeroBuscado
        ? 'Menor'
        : numeroElegido < numeroBuscado
            ? 'Mayor'
            : 'Igual';
  }

  static String dificultad(int value) {
    return value == 0
        ? 'Fácil'
        : value == 1
            ? 'Medio'
            : value == 2
                ? 'Avanzado'
                : 'Extremo';
  }
}
