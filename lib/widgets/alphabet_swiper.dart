import 'package:abc/widgets/letter_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:abc/models/word.dart';

final List<String> alphabet = List.unmodifiable(
  [
    ...List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index)),
    'Å', 'Ä', 'Ö'
  ]
);

class AlphabetSwiper extends StatefulWidget {
  const AlphabetSwiper({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AlphabetSwiperState createState() => _AlphabetSwiperState();
}

class _AlphabetSwiperState extends State<AlphabetSwiper> {
  late SwiperController _swiperController;

  @override
  void initState() {
    super.initState();
    _swiperController = SwiperController();
  }

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double maxFontSize = constraints.maxHeight * 0.6;
        return Consumer<WordModel>(
          builder: (context, model, child) {
            return Swiper(
              duration: 1,
              controller: _swiperController,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return LetterPickerDialog(
                          alphabet: alphabet,
                          onLetterSelected: (letter) {
                            int letterIndex = alphabet.indexOf(letter);
                            if (letterIndex != -1) {
                              model.letter = letter;
                              _swiperController.move(letterIndex, animation: true);
                              (context as Element).markNeedsBuild();
                            }
                          },
                        );
                      },
                    );
                  },
                  child: Center(
                    child: Text(
                      alphabet[index],
                      style: TextStyle(
                        fontSize: maxFontSize,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
              itemCount: alphabet.length,
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