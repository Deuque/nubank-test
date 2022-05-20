import 'package:code_test/repository/alias_repository.dart';
import 'package:code_test/repository/data/response_model.dart';
import 'package:code_test/repository/data/shortened_url_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAliasCubit extends Cubit<CreateAliasState> {
  AliasRepository repository;

  CreateAliasCubit(this.repository) : super(const CreateAliasState());

  void processUrl(String url) async {
    emit(state.withLoading());
    ResponseModel response = await repository.createAlias(url);

    if (response is SuccessResponse<ShortenedUrl>) {
      emit(CreateAliasState(shortenedUrl: response.value));
    } else if (response is ErrorResponse) {
      emit(state.withError(response.error));
    }
  }
}

class CreateAliasState extends Equatable {
  final bool? loading;
  final String? error;
  final ShortenedUrl? shortenedUrl;

  const CreateAliasState({this.loading, this.error, this.shortenedUrl});

  CreateAliasState withLoading() => const CreateAliasState(
        loading: true,
      );

  CreateAliasState withError(String error) => CreateAliasState(
        error: error,
      );

  @override
  List<Object?> get props => [loading, error, shortenedUrl];
}
