import 'package:abc/models/word.dart';
import 'package:abc/widgets/alphabet_swiper.dart';
import 'package:abc/widgets/word_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;
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
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 300.0, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 100.0, color: Colors.black),
        )
      ),
      home: Scaffold(
        body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) { 
            var isPortrait = orientation == Orientation.portrait;

            return Flex(
              direction: isPortrait ? Axis.vertical : Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Expanded(
                  child: AlphabetSwiper(),
                ),
                Expanded(
                  child: WordDisplay(),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<WordModel>(context, listen: false).shuffleWords();
          },
          child: const Icon(Icons.refresh),
        )
      ),
    );
  }
}