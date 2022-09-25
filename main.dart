// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp()); //rodando o app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Startup Name Generator'),
        ),
        body: const Center(
          child: RandomWords(), //chamando o builder da classe random words
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  //classe de palavras aleatorias
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final wordPair =
        WordPair.random(); //duas palavras aleatórias são colocadas juntas
    final _suggestions =
        <WordPair>[]; // salva as palavras formadas juntas, em um array
    final _saved = <WordPair>{}; //salva a palavra favoritada
    final _biggerFont = const TextStyle(fontSize: 18); //aumenta a fonte
    // o widget retorna um par de palavras aletórias do inglês, com cada palavra começando com letra maiúscula
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return const Divider(); /*2*/
        final index = i ~/ 2; /*3*/
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(
              10)); /*4 vai atualizando e gerando 10 novas palavras juntas à medida que o usuário vai rolando a tela pra baixo*/
        }
        final alreadySaved =
            _saved.contains(_suggestions[index]); // palavra já salvada
        return ListTile(
          //retorna uma lista bem formatadazinha das palavras juntas
          title: Text(
            _suggestions[index].asPascalCase,
            style: _biggerFont,
          ),
          trailing: Icon(
            // Colocando o ícone do coração
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
            semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
          ),
          onTap: () {
            setState(() {
              if (alreadySaved) {
                _saved.remove(_suggestions[index]);
              } else {
                _saved.add(_suggestions[index]);
              }
            });
          },
        );
      },
    );
  }
}
