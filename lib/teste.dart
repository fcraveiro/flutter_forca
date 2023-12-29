import 'dart:developer';
import 'package:flutter/material.dart';

class Pagina1 extends StatefulWidget {
  const Pagina1({Key? key}) : super(key: key);

  @override
  State<Pagina1> createState() => _Pagina1State();
}

class _Pagina1State extends State<Pagina1> {
  final String texto = 'Olá, mundo divertido do flutter!';
  List<Widget> listaDeContainers = [];
  List<String> itensSoltos = [];
  List<Widget> containersSoltos = [];

  @override
  void initState() {
    super.initState();

    List<String> palavras = dividirTextoEmPalavras(texto);

    for (String palavra in palavras) {
      listaDeContainers.add(Draggable<String>(
        data: palavra,
        feedback: formatarContainer(palavra, isBeingDragged: true),
        childWhenDragging: Container(),
        child: formatarContainer(palavra),
      ));
    }
  }

  Widget formatarContainer(String palavra, {bool isBeingDragged = false}) {
    return Container(
      height: 25,
      width: (palavra.length * 15.0) + 10,
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isBeingDragged ? Colors.transparent : Colors.blue,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.blue,
        ),
      ),
      child: Center(
        child: Text(
          palavra,
          style: TextStyle(
            color: isBeingDragged ? Colors.blue : Colors.white,
          ),
        ),
      ),
    );
  }

  List<String> dividirTextoEmPalavras(String texto) {
    return texto.split(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina 1'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Wrap(
              children: [
                ...listaDeContainers,
              ],
            ),
            const SizedBox(height: 20),
            DragTarget<String>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Wrap(
                    spacing: 8.0, // Espaçamento entre os containers
                    children: containersSoltos,
                  ),
                );
              },
              onWillAccept: (data) {
                return true;
              },
              onAccept: (data) {
                log('Item $data foi solto na área de destino!');
                setState(() {
                  listaDeContainers.removeWhere((element) =>
                      element is Draggable && element.data == data);
                  itensSoltos.add(data);
                  containersSoltos.add(formatarContainer(data));
                });
              },
              onLeave: (data) {
                log('Item $data foi removido da área de destino!');
              },
            ),
          ],
        ),
      ),
    );
  }
}
