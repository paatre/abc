import 'package:abc/models/word.dart';
import 'package:abc/widgets/refresh_word_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';

class WordsSwiper extends StatelessWidget {
  const WordsSwiper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WordModel>(builder: (context, model, child) {
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
            child: Consumer<WordModel>(
              builder: (context, model, child) {
                return RefreshWordButton(
                  onPressed: model.shuffleWords,
                );
              }, 
            ),
          ),
        ], 
      );
    });
  }
}