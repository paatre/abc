import 'package:abc/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';

class AlphabetSwiper extends StatelessWidget {
  const AlphabetSwiper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WordModel>(builder: (context, model, child) {
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
    });
  }
}