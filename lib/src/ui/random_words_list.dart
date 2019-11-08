import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = [];
  final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _textStyle = TextStyle(
    fontSize: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nomes para Startup'),
      ),
      body: Center(
        child: _buildSuggestion(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.favorite,
          color: Colors.red,
        ),
        label: Text("FAVORITOS"),
        onPressed: _pushSaved,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildSuggestion() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      itemBuilder: (context, i) {
        // Adiciona um widget divisor depois de uma linha da lista
        if (i.isOdd) return Divider(); //Verifica se é uma posição impar e retorna um divisor
        // A sintaxe " i~/2 " divide i por 2 e retorna um resultado inteiro.
        // Por exemplo: 1,2,3,4,5 se torna 0,1,1,2,2
        // Isso calcula o número atual de pares de palavras no ListView, menos os widget divisores
        final int index = i ~/ 2; // Se as suas linhas estiverem acabando...
        if (index >= _suggestions.length) {
          //... é gerado mais 10 itens e são adicionados a lista de sugestão.
          _suggestions.addAll(generateWordPairs().take(5));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _textStyle,
      ),
      trailing: IconButton(
        onPressed: () {
          setState(() {
            alreadySaved ? _saved.remove(pair) : _saved.add(pair);
          });
        },
        highlightColor: Colors.redAccent[100],
        splashColor: Colors.redAccent[400],
        color: alreadySaved ? Colors.red : null,
        icon: alreadySaved ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair) =>
                ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _textStyle,
                  ),
                ),
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Sugestões Salvas'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
