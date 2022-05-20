import 'package:bloc_test/bloc_test.dart';
import 'package:code_test/bloc/create_alias_cubit.dart';
import 'package:code_test/repository/data/response_model.dart';
import 'package:code_test/repository/data/shortened_url_model.dart';

import '../mocks/mock_create_alias_cubit.dart';

void main() {
  ShortenedUrl testShortenedUrl =
      const ShortenedUrl(alias: 'a1', short: '', original: '');

  blocTest<CreateAliasCubit, CreateAliasState>(
    'emits shortened url when url is processed successfully',
    build: () => CreateAliasCubit(
      MockAliasRepository(
        SuccessResponse(testShortenedUrl),
      ),
    ),
    act: (bloc) => bloc.processUrl(''),
    expect: () => [
      const CreateAliasState(loading: true),
      CreateAliasState(
        shortenedUrl: testShortenedUrl,
      ),
    ],
  );

  blocTest<CreateAliasCubit, CreateAliasState>(
    'emits error state when url is processed with error',
    build: () => CreateAliasCubit(
      MockAliasRepository(
        ErrorResponse('error'),
      ),
    ),
    act: (bloc) => bloc.processUrl(''),
    expect: () => [
      const CreateAliasState(loading: true),
      const CreateAliasState(error: 'error'),
    ],
  );
}
