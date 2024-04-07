// ignore_for_file: avoid_print
import 'package:adivina_el_numero/functions/logic.dart';
import 'package:adivina_el_numero/widgets/contenedores.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _numeroController = TextEditingController();
  double _slideValue = 0;
  int _intentos = 0;
  String _dificultad = 'Fácil';
  String _hint = '';
  String _rango = '';
  String _textoInteractivo = '¿Estas listo?';
  int _length = 2;
  int _numeroBuscado = 0;
  List<Widget> menor = [
    const Text('Menor que', style: TextStyle(fontSize: 20))
  ];
  List<Widget> mayor = [
    const Text(
      'Mayor que',
      style: TextStyle(fontSize: 20.0),
    ),
  ];
  List<Widget> historial = [
    const Text(
      'Historial',
      style: TextStyle(fontSize: 20.0),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _intentos = Logic.generarNumero(_dificultad)[1];
    _hint = Logic.generarNumero(_dificultad)[2];
    _rango = Logic.generarNumero(_dificultad)[3];
    _length = Logic.generarNumero(_dificultad)[4];
    _numeroBuscado = Logic.generarNumero(_dificultad)[0];
    print('Busca: $_numeroBuscado');
  }

  alerta(String tipo) {
    tipo == 'lose'
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('¡UPS! Suerte para la proxima'),
                content: const Text('¿Quieres volver a intentarlo?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      reinicio();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Si, quiero volver a intentarlo',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              );
            },
          )
        : showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('PRECAUCION'),
                content: const Text('¿Seguro que quieres borrar el historial?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      reinicio();
                      Navigator.of(context).pop();
                      historial = [
                        const Text('Historial',
                            style: TextStyle(fontSize: 20.0))
                      ];
                    },
                    child: const Text(
                      'Si',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              );
            },
          );
  }

  reinicio() {
    setState(() {
      _dificultad = Logic.dificultad(_slideValue.toInt());
      _numeroBuscado = Logic.generarNumero(_dificultad)[0];
      _intentos = Logic.generarNumero(_dificultad)[1];
      _hint = Logic.generarNumero(_dificultad)[2];
      _rango = Logic.generarNumero(_dificultad)[3];
      _length = Logic.generarNumero(_dificultad)[4];
      _numeroController.clear();
      _textoInteractivo = '¿Estas listo?';
      menor = [const Text('Menor que', style: TextStyle(fontSize: 20))];
      mayor = [const Text('Mayor que', style: TextStyle(fontSize: 20.0))];
      print('Busca: $_numeroBuscado');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 42, 41, 41),
          elevation: 10,
          shadowColor: Colors.grey,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Adivina el número',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: () {
                  alerta('');
                },
                icon: const Icon(
                  Icons.replay_outlined,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.grey,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(
                      'Dime un número entre 1 y $_rango',
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      //Input
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            controller: _numeroController,
                            keyboardType: TextInputType.number,
                            maxLength: _length,
                            onFieldSubmitted: (String value) {
                              setState(() {
                                _numeroController.clear();
                                List<dynamic> result = Logic.validarNumero(
                                  value,
                                  _numeroBuscado,
                                  _intentos,
                                  mayor,
                                  menor,
                                  historial,
                                );
                                _intentos = result[0];
                                mayor = result[1];
                                menor = result[2];
                                historial = result[3];
                                result[4] == 'Bien'
                                    ? reinicio()
                                    : _intentos == 0
                                        ? alerta('lose')
                                        : null;
                                _textoInteractivo = Logic.frases();
                              });
                            },
                            decoration: InputDecoration(
                              label: const Text('Ingrese un número'),
                              hintText: _hint,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Intentos
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'Intentos restantes: ',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Text(
                              _intentos.toString(),
                              style: const TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Contenedores(lista: mayor),
                      Contenedores(lista: menor),
                      Contenedores(lista: historial),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Dificultad: $_dificultad',
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Slider(
                    value: _slideValue,
                    divisions: 3,
                    max: 3,
                    label: _dificultad,
                    onChanged: (double value) {
                      setState(() {
                        _slideValue = value;
                      });
                      reinicio();
                    },
                  ),
                  Text(
                    _textoInteractivo,
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
