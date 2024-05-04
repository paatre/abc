import 'package:abc/models/word.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(
    ChangeNotifierProvider(
      create: (context) => WordModel(),
      child: const ABC(),
    ),
  );
}

class ABC extends StatelessWidget {
  const ABC({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aakkosten harjoittelua',
      home: Scaffold(
        body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) { 
            if (orientation == Orientation.portrait) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Consumer<WordModel>(builder: (context, model, child) {
                      return Swiper(
                        itemCount: model.alphabet.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Text(
                              model.alphabet[index],
                              style: const TextStyle(fontSize: 300),
                            ),
                          );
                        },
                        onIndexChanged: (index) {
                          model.letter = model.alphabet[index];
                        },
                      );
                    }),
                  ),
                  Flexible(
                    flex: 1,
                    child: Consumer<WordModel>(builder: (context, model, child) {
                      List<String> words = model.words
                        .where((word) => word.startsWith(model.letter.toLowerCase()))
                        .toList();
                      if (words.isEmpty) {
                        return Center(child: Text("No words starting with '${model.letter}'"));
                      }
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
                                      words[index],
                                      style: const TextStyle(fontSize: 100),
                                    ),
                                  );
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
                              onPressed: model.shuffleWords,
                              mouseCursor: MaterialStateMouseCursor.clickable,
                            ),
                          ),
                        ], 
                      );
                    }),
                  ) 
                ],
              );
            } else {
              return const Text('Landscape mode not supported');
            }
          },
        ),
      ),
    );
  }
}