import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/rule_model.dart';

String token = dotenv.env['TOKEN']!;
String baseUrl = dotenv.env['BASE_URL']!;

class ListController extends GetxController {
  final _listRules = <Rule>[].obs;
  get listRules => _listRules;

  final RxBool _loading = true.obs;
  bool get loading => _loading.value;

  final RxInt _currentPage = 1.obs;
  int get currentPage => _currentPage.value;

  final RxInt _totalPages = 1.obs;
  int get totalPages => _totalPages.value;

  String _nextLink = '';

  String _prevLink = '';

  // SHOW RULES LIST
  void getRules({String? nextLink, String? prevLink}) async {
    _loading.value = true;
    try {
      String url = baseUrl;
      if (nextLink != null) {
        url = nextLink;
      } else if (prevLink != null) {
        url = prevLink;
      }

      final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
      final response = await http.get(Uri.parse(url), headers: headers);

      var jsonResponse = jsonDecode(response.body);
      List<Rule> list = jsonResponse['data']['entities']
          .map<Rule>((item) => Rule.fromMap(item))
          .toList();

      _listRules.clear();
      _listRules.assignAll(list);
      _currentPage.value = jsonResponse['data']['pagination']['current_page'];
      _totalPages.value = jsonResponse['data']['pagination']['total_pages'];
      _nextLink = jsonResponse['data']['pagination']['links']['next'] ?? '';
      _prevLink = jsonResponse['data']['pagination']['links']['prev'] ?? '';

      _loading.value = false;
    } catch (error) {
      _loading.value = false;
      Get.snackbar(
        'Get rules list error:',
        '$error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void Function()? prevPage() {
    return _prevLink.isNotEmpty
        ? () => getRules(prevLink: _prevLink.replaceFirst('http', 'https'))
        : null;
  }

  void Function()? nextPage() {
    return _nextLink.isNotEmpty
        ? () => getRules(nextLink: _nextLink.replaceFirst('http', 'https'))
        : null;
  }
}
