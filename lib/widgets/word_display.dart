import 'package:abc/models/word.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WordDisplay extends StatelessWidget {
  const WordDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double maxFontSize = constraints.maxHeight * 0.4;
        return Consumer<WordModel>(
          builder: (context, model, child) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: AutoSizeText(
                  model.word,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: maxFontSize,
                    letterSpacing: 2,
                    color: Colors.black,
                  )
                ),
              ),
            );
          }
        );
      }
    );
  }
}
