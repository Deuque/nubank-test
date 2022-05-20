import 'package:code_test/repository/alias_repository.dart';
import 'package:code_test/repository/data/response_model.dart';

class MockAliasRepository implements AliasRepository {
  final ResponseModel mockResponseModel;

  MockAliasRepository(this.mockResponseModel);

  @override
  Future<ResponseModel> createAlias(String urlToBeShortened) {
    return Future.value(mockResponseModel);
  }
}
