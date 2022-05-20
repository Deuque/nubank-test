import 'package:code_test/bloc/create_alias_cubit.dart';
import 'package:code_test/bloc/recent_urls_cubit.dart';
import 'package:code_test/repository/data/response_model.dart';
import 'package:code_test/repository/data/shortened_url_model.dart';
import 'package:code_test/screens/url_shortner/url_shortner_screen.dart';
import 'package:code_test/screens/url_shortner/widgets/recently_shortened_urls_widget.dart';
import 'package:code_test/screens/url_shortner/widgets/url_entry_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/mock_create_alias_cubit.dart';
import 'page_object.dart';

void main() {
  testWidgets('shows empty recent urls layout when recent urls is empty',
      (tester) async {
    final pageObject = _UrlShortenerPageObject(tester);
    await tester.pumpWidget(_layout());
    expect(pageObject.emptyRecentUrlsLayout, findsOneWidget);
    expect(pageObject.loadedRecentUrlsLayout, findsNothing);
  });

  testWidgets('shows loaded recent urls layout when recent urls is not empty',
      (tester) async {
    final pageObject = _UrlShortenerPageObject(tester);
    await tester.pumpWidget(_layout());

    // enter url and tap send
    await tester.enterText(pageObject.urlTextField, 'http://google.com');
    await pageObject.tapView(pageObject.activeSendButton);

    expect(pageObject.loadedRecentUrlsLayout, findsOneWidget);
    expect(find.text('a1'), findsOneWidget);
    expect(find.text('google'), findsOneWidget);
    expect(pageObject.emptyRecentUrlsLayout, findsNothing);

    // swipe to delete recent url
    await tester.drag(find.byType(Dismissible), const Offset(500.0, 0.0));
    await tester.pumpAndSettle();
    expect(pageObject.emptyRecentUrlsLayout, findsOneWidget);
    expect(pageObject.loadedRecentUrlsLayout, findsNothing);
  });
}

ShortenedUrl testShortenedUrl =
    const ShortenedUrl(alias: 'a1', short: 'google', original: '');

Widget _layout() => MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CreateAliasCubit(
              MockAliasRepository(SuccessResponse(testShortenedUrl)),
            ),
          ),
          BlocProvider(
            create: (_) => RecentUrlsCubit(),
          )
        ],
        child: const UrlShortenerScreen(),
      ),
    );

class _UrlShortenerPageObject extends PageObject<UrlShortenerScreen> {
  _UrlShortenerPageObject(super.tester);

  Finder get urlTextField =>
      pageFinder(find.byKey(UrlEntryWidgetKeys.urlTextField));

  Finder get activeSendButton =>
      pageFinder(find.byKey(UrlEntryWidgetKeys.activeSendButton));

  Finder get processingUrlLoader =>
      pageFinder(find.byKey(UrlEntryWidgetKeys.processingUrlLoader));

  Finder get emptyRecentUrlsLayout =>
      pageFinder(find.byKey(RecentlyShortenedUrlsWidgetKeys.emptyDataLayout));

  Finder get loadedRecentUrlsLayout =>
      pageFinder(find.byKey(RecentlyShortenedUrlsWidgetKeys.loadedUrlLayout));
}
