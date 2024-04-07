import 'package:adivina_el_numero/functions/logic.dart';
import 'package:adivina_el_numero/widgets/custom_appbar.dart';
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

  reinicio() {
    setState(() {
      _dificultad = Logic.dificultad(_slideValue.toInt());
      _numeroBuscado = Logic.generarNumero(_dificultad)[0];
      _intentos = Logic.generarNumero(_dificultad)[1];
      _hint = Logic.generarNumero(_dificultad)[2];
      _rango = Logic.generarNumero(_dificultad)[3];
      _length = Logic.generarNumero(_dificultad)[4];
      _numeroController.clear();
      menor = [const Text('Menor que', style: TextStyle(fontSize: 20))];
      mayor = [const Text('Mayor que', style: TextStyle(fontSize: 20.0))];
      print('Busca: $_numeroBuscado');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppbar(
          title: 'Adivina el número',
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            controller: _numeroController,
                            keyboardType: TextInputType.number,
                            maxLength: _length,
                            onFieldSubmitted: (String value) {
                              setState(() {
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
                                        ? reinicio()
                                        : null;
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: size.height * 0.35,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              children: mayor,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: size.height * 0.35,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              children: menor,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: size.height * 0.35,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              children: historial,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Dificultad: $_dificultad',
                    style: const TextStyle(fontSize: 20.0),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
