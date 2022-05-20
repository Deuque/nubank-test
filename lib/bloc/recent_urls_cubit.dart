import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:code_test/repository/data/shortened_url_model.dart';

class RecentUrlsCubit extends Cubit<List<ShortenedUrl>> {
  RecentUrlsCubit() : super([]);

  void addNewShortenedUrl(ShortenedUrl shortenedUrl) {
    final hasUrl = state.where((e) => e == shortenedUrl).isNotEmpty;
    if (!hasUrl) {
      emit([shortenedUrl, ...state]);
    }
  }

  void removeShortenedUrl(String alias) {
    emit(state.where((e) => e.alias != alias).toList());
  }
}
