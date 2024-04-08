import 'dart:math';

import 'package:flutter/material.dart';

class Logic {
  static String frases() {
    List<String> list = [
      'Eso estuvo cerca',
      '¡Ja! ni te acercas',
      'Vamos, ¿eso es todo?',
      'Vamos, vuelve a intentarlo',
    ];
    Random random = Random();
    int indiceAleatorio = random.nextInt(list.length);
    return list[indiceAleatorio];
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

  static List generarNumero(String dificultad) {
    var random = Random();
    switch (dificultad) {
      case 'Fácil':
        return [random.nextInt(10) + 1, 5, '##', '10', 2];
      case 'Medio':
        return [random.nextInt(20) + 1, 8, '##', '20', 2];
      case 'Avanzado':
        return [random.nextInt(100) + 1, 15, '###', '100', 3];
      case 'Extremo':
        return [random.nextInt(1000) + 1, 25, '####', '1000', 4];
      default:
        return [random.nextInt(10) + 1, 5, '##', '10', 2];
    }
  }

  static List<dynamic> validarNumero(
      String numeroElegido,
      int numeroBuscado,
      int intentos,
      List<Widget> mayor,
      List<Widget> menor,
      List<Widget> historial) {
    if (intentos - 1 != 0) {
      int? numeroIngresado = int.tryParse(numeroElegido);
      if (numeroIngresado != null) {
        if (numeroIngresado > numeroBuscado) {
          menor.add(Text(numeroElegido,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              )));
          intentos -= 1;
        } else if (numeroIngresado < numeroBuscado) {
          mayor.add(Text(numeroElegido,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              )));
          intentos -= 1;
        } else {
          historial.add(Text(numeroBuscado.toString(),
              style: const TextStyle(
                  fontSize: 20.0, color: Color.fromARGB(255, 47, 154, 51))));
          return [intentos, mayor, menor, historial, 'Bien'];
        }
      }
    } else {
      intentos -= 1;
      historial.add(Text(numeroBuscado.toString(),
          style: const TextStyle(
              fontSize: 20.0, color: Color.fromARGB(255, 170, 38, 38))));
      return [intentos, mayor, menor, historial, 'Mal'];
    }
    return [intentos, mayor, menor, historial, 'Mal'];
  }
}
