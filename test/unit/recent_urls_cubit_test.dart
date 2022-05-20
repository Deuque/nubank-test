import 'package:bloc_test/bloc_test.dart';
import 'package:code_test/bloc/recent_urls_cubit.dart';
import 'package:code_test/repository/data/shortened_url_model.dart';

void main() {
  ShortenedUrl testShortenedUrl =
      const ShortenedUrl(alias: 'a1', short: '', original: '');
  blocTest<RecentUrlsCubit, List<ShortenedUrl>>(
    'emits list with new data when shortened url is added',
    build: () => RecentUrlsCubit(),
    act: (bloc) => bloc.addNewShortenedUrl(testShortenedUrl),
    expect: () => [
      const [ShortenedUrl(alias: 'a1', short: '', original: '')],
    ],
  );

  blocTest<RecentUrlsCubit, List<ShortenedUrl>>(
    'emits list without data when shortened url is removed',
    build: () => RecentUrlsCubit(),
    act: (bloc) => bloc
      ..addNewShortenedUrl(testShortenedUrl)
      ..removeShortenedUrl('a1'),
    expect: () => [
      [testShortenedUrl],
      const [],
    ],
  );
}
