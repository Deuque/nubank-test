import 'dart:convert';

import 'package:code_test/repository/data/repo_constants.dart';
import 'package:code_test/repository/data/response_model.dart';
import 'package:code_test/repository/data/shortened_url_model.dart';
import 'package:http/http.dart' as http;

class AliasRepository {
  Future<ResponseModel> createAlias(String urlToBeShortened) {
    return HttpCaller.makeCall(
      call: () => http.post(
        Uri.parse(createAliasUrl),
        body: jsonEncode({'url': urlToBeShortened}),
        headers: {'content-type': 'application/json'},
      ),
      onError: (error, code) => ErrorResponse(error),
      onSuccess: (response) {
        Map<String, dynamic> decodedValue = jsonDecode(response.body);
        return SuccessResponse(
          ShortenedUrl(
            alias: decodedValue['alias'],
            short: decodedValue['_links']['short'],
            original: decodedValue['_links']['self'],
          ),
        );
      },
    );
  }
}
