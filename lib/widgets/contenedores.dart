import 'package:flutter/material.dart';

class Contenedores extends StatelessWidget {
  const Contenedores({
    super.key,
    required this.lista,
  });

  final List<Widget> lista;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Expanded(
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
            children: lista,
          ),
        ),
      ),
    );
  }
}
