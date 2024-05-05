import 'package:abc/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';

final alphabet = List.unmodifiable(
    List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index))
);

class AlphabetSwiper extends StatelessWidget {
  const AlphabetSwiper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) { 
        final double maxFontSize = constraints.maxHeight * 0.6;
        return Consumer<WordModel>(
          builder: (context, model, child) {
            return Swiper(
              itemCount: alphabet.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    alphabet[index],
                    style: TextStyle(
                      fontSize: maxFontSize ,
                      color: Colors.black,
                    ),
                  ),
                );
              },
              onIndexChanged: (index) {
                model.letter = alphabet[index];
              },
            );
          },
        );
      },
    );
  }
}