import 'package:abc/widgets/alphabet_swiper.dart';
import 'package:abc/widgets/word_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:abc/main.dart';
import 'package:abc/models/word.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();  

  testWidgets('App initializes and displays AlphabetSwiper and WordDisplay', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => WordModel(),
        child: const ABC(),
      ),
    );

    // Verify presence of AlphabetSwiper and WordDisplay widgets
    expect(find.byType(AlphabetSwiper), findsOneWidget);
    expect(find.byType(WordDisplay), findsOneWidget);

    // Verify presence of FloatingActionButton
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
