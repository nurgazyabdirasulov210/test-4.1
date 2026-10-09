import 'dart:convert';

import 'package:http/http.dart' as http;

class PagedResponse {
  PagedResponse(this.pages, this.results);
  final int pages;
  final List<Map<String, dynamic>> results;
}

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  static const _base = 'https://rickandmortyapi.com/api';
  final http.Client _client;

  Future<PagedResponse> getPage(String resource, int page) async {
    final res = await _client.get(Uri.parse('$_base/$resource?page=$page'));
    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}');
    }
    final json = jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
    return PagedResponse(
      json['info']['pages'] as int,
      (json['results'] as List).cast<Map<String, dynamic>>(),
    );
  }

  /// Загружает все страницы ресурса (первая последовательно, остальные параллельно).
  Future<List<Map<String, dynamic>>> getAll(String resource) async {
    final first = await getPage(resource, 1);
    final rest = await Future.wait([
      for (var p = 2; p <= first.pages; p++) getPage(resource, p),
    ]);
    return [first.results, for (final r in rest) r.results]
        .expand((e) => e)
        .toList();
  }
}
