import 'dart:math';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<String> palavras1 = ['maçã', 'banana', 'uva', 'laranja', 'morango'];
  List<String> palavras2 = ['fruta', 'fruta', 'fruta', 'fruta', 'fruta'];
  String palavraSorteada = '';
  String palavraAssociada = '';

  @override
  void initState() {
    super.initState();
    _sortearPalavra();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game de Associação'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Palavra sorteada: $palavraSorteada'),
            DragTarget<String>(
              onAccept: (value) {
                _verificarAssociacao(value);
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                );
              },
            ),
            Container(
              color: Colors.white,
              height: 50,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: palavras2.length,
                itemBuilder: (context, index) {
                  return Draggable<String>(
                    data: palavras2[index],
                    feedback: Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 3, color: Colors.black)),
                      child: Center(
                        child: Text(palavras2[index]),
                      ),
                    ),
                    child: Container(
                      width: 100,
                      height: 30,
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1, color: Colors.black)),
                      child: SizedBox(
                        child: Center(
                          child: Text(palavras2[index]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sortearPalavra() {
    int index = Random().nextInt(palavras1.length);
    palavraSorteada = palavras1[index];
  }

  void _verificarAssociacao(String palavraAssociada) {
    int index = palavras1.indexOf(palavraSorteada);
    String palavraCorreta = palavras2[index];

    if (palavraAssociada == palavraCorreta) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Parabéns!'),
            content: const Text('Você acertou a associação.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _sortearPalavra();
                },
                child: const Text('Continuar'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Ops!'),
            content: const Text('Você errou a associação.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tentar novamente'),
              ),
            ],
          );
        },
      );
    }
  }
}
