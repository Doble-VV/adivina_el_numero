import 'package:adivina_el_numero/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _slideValue = 0;
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
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: const Text('Ingrese un número'),
                              hintText: '####',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 6, 96, 10),
                                  width: 5.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Intentos restantes: ',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Text(
                              '5',
                              style: TextStyle(fontSize: 20.0),
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
                            child: const Column(
                              children: [
                                Text(
                                  'Mayor que',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ],
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
                            child: const Column(
                              children: [
                                Text(
                                  'Menor que',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ],
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
                            child: const Column(
                              children: [
                                Text(
                                  'Historial',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Dificultad: ',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Slider(
                    value: _slideValue,
                    divisions: 3,
                    max: 3,
                    label: 'Facil',
                    onChanged: (double value) {
                      _slideValue = value;
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
