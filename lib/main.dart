import 'package:abc/models/word.dart';
import 'package:abc/widgets/alphabet_swiper.dart';
import 'package:abc/widgets/words_swiper.dart';
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
      home: Scaffold(
        body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) { 
            if (orientation == Orientation.portrait) {
              return const PortraitLayout();
            } else {
              return const Text('Landscape mode not supported');
            }
          },
        ),
      ),
    );
  }
}

class PortraitLayout extends StatelessWidget {
  const PortraitLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: AlphabetSwiper(),
        ),
        Flexible(
          flex: 1,
          child: WordsSwiper(),
        ) 
      ],
    );
  }
}
