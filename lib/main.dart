import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiMode, SystemUiOverlay, rootBundle;
import 'package:flutter_swiper_view/flutter_swiper_view.dart';


final alphabet = List.unmodifiable(
  List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index))
);

final allWords = List<String>.empty(growable: true);

Future<List<String>> _loadWords() async {
  if (kDebugMode) {
    print("Loading...");
  }
  final stopwatch = Stopwatch()..start();
  try {
    final data = await rootBundle.loadString('assets/data/words');
    final lines = data.split('\n');
    stopwatch.stop(); 
    if (kDebugMode) {
      print('Loaded ${lines.length} lines in ${stopwatch.elapsedMilliseconds} milliseconds');
    }
    return lines;
  } catch (e) {
    stopwatch.stop();
    if (kDebugMode) {
      print('An error occurred while reading the file: $e');
    }
    return [];
  }
}

void main() {
  runApp(const ABC());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack, overlays: [SystemUiOverlay.bottom]);
}

class ABC extends StatelessWidget {
  const ABC({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aakkosten harjoittelua',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MyHomePage>{
  late Future<List<String>> _wordsFuture = Future.value(List<String>.empty(growable: true));
  var _letter = 'A';
  var _word = '';

  @override
  void initState() {
    super.initState();
    _wordsFuture = _loadWords();
  }

  List<String> wordsStartingWith(String letter) {
    return allWords.where((word) => word.startsWith(letter.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Swiper(
              itemCount: alphabet.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    alphabet[index],
                    style: const TextStyle(fontSize: 300),
                  ),
                );
              },
              onIndexChanged: (index) {
                setState(() {
                  _letter = alphabet[index];
                });
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: FutureBuilder(
              future: _wordsFuture,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading words: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<String> words = snapshot.data!
                    .where((String word) => word.startsWith(_letter.toLowerCase()))
                    .toList();
                  if (words.isEmpty) {
                    return Center(child: Text("No words starting with '$_letter'"));
                  }
                  _word = (words..shuffle()).first;
                  return Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Swiper(
                            itemCount: words.length,
                            itemBuilder: (context, index) {
                              return Center(
                                child: AutoSizeText(
                                  _word,
                                  style: const TextStyle(fontSize: 100),
                                ),
                              );
                            },
                            onIndexChanged: (index) {
                              if (words.isNotEmpty) {
                                setState(() {
                                  _word = words[index];
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: IconButton.outlined(
                          style: OutlinedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(8),
                            side: const BorderSide(color: Colors.grey, width: 3)
                          ),
                          icon: const Icon(Icons.refresh),
                          iconSize: 64,
                          onPressed: () {
                            setState(() {
                              _word = (words..shuffle()).first;
                            });
                          },
                          mouseCursor: MaterialStateMouseCursor.clickable,
                        ),
                      ),
                    ], 
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ) 
          ),
        ],
      ),
    );
  }
}