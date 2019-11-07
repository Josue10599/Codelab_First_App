import 'package:english_words/english_words.dart' as word;
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final List<word.WordPair> _suggestions = [];
  final TextStyle _textStyle = TextStyle(
    fontSize: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name'),
        centerTitle: true,
      ),
      body: Center(
        child: _buildSuggestion(),
      ),
    );
  }

  Widget _buildSuggestion() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, i) {
        // Adiciona um widget divisor depois de uma linha da lista
        if (i.isOdd) return Divider(); //Verifica se é uma posição impar e retorna um divisor
        // A sintaxe " i~/2 " divide i por 2 e retorna um resultado inteiro.
        // Por exemplo: 1,2,3,4,5 se torna 0,1,1,2,2
        // Isso calcula o número atual de pares de palavras no ListView, menos os widget divisores
        final int index = i ~/ 2; // Se as suas linhas estiverem acabando...
        if (index >= _suggestions.length) {
          //... é gerado mais 10 itens e são adicionados a lista de sugestão.
          _suggestions.addAll(word.generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(word.WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _textStyle,
      ),
    );
  }
}
