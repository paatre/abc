import 'package:flutter/material.dart';

class LetterPickerDialog extends StatelessWidget {
  final List<String> alphabet;
  final Function(String) onLetterSelected;

  const LetterPickerDialog({
    super.key,
    required this.alphabet,
    required this.onLetterSelected,
  });

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    int crossAxisCount = orientation == Orientation.portrait ? 3 : 6; // Adjust based on the orientation

    return Dialog(
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 2.0,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: alphabet.length,
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () {
              onLetterSelected(alphabet[index]);
              Navigator.of(context).pop();
            },
            child: Text(alphabet[index]),
          );
        },
      ),
    );
  }
}
