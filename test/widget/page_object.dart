import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

abstract class PageObject<T> {
  final WidgetTester tester;

  PageObject(this.tester);

  Finder pageFinder(Finder matcher) => find.descendant(
        of: find.byType(T),
        matching: matcher,
      );

  Finder get widget => find.byType(T);

  Finder get scrollable => find.byType(Scrollable).first;

  Future<void> scrollTo(Finder view, [double delta = 50]) async {
    await tester.scrollUntilVisible(view, delta, scrollable: scrollable);
  }

  Future<void> tapView(Finder view, {bool scrollFirst = true}) async {
    if (scrollFirst) await scrollTo(view);
    await tester.tap(view);
    await tester.pumpAndSettle();
  }
}
