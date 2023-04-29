import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rules/models/rule_model.dart';

String token = dotenv.env['TOKEN']!;
String baseUrl = dotenv.env['BASE_URL']!;

class RuleController extends GetxController {
  final Rx<Rule> _ruleData = Rule(active: 1, id: 0, name: '', order: 0).obs;
  Rule get ruleData => _ruleData.value;

  final RxBool _loading = false.obs;
  bool get loading => _loading.value;

  void setLoading(bool value) {
    _loading.value = value;
  }

  final RxBool _enableEditing = false.obs;
  bool get enableEditing => _enableEditing.value;

  final RxBool _activeSwitch = true.obs;
  bool get activeSwitch => _activeSwitch.value;

  void setActiveSwitch(bool value) {
    _activeSwitch.value = value;
    _ruleData.value.active = value ? 1 : 0;
  }

  void enableEdit() {
    _enableEditing.value = !_enableEditing.value;
  }

  void setRuleName(String name) {
    _ruleData.value.name = name;
  }

  Future<dynamic> backNavigation() {
    // restart state of HomeScreen
    // and update list
    return Get.toNamed('/home')!;
  }

  // SHOW RULE
  void getRuleDetails(String id) async {
    _loading.value = true;
    try {
      final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
      final response =
          await http.get(Uri.parse('$baseUrl/$id'), headers: headers);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        Rule rule = Rule.fromMap(jsonResponse['data']);
        _ruleData.value = rule;
      }
      _loading.value = false;
    } catch (error) {
      _loading.value = false;
      Get.snackbar(
        'Get rule detail error:',
        '$error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // UPDATE RULE
  void updateRuleDetails() async {
    _loading.value = true;
    try {
      final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
      final response = await http.put(
          Uri.parse('$baseUrl/${_ruleData.value.id}'),
          headers: headers,
          body: jsonEncode({"house_rules": _ruleData.value.toMap()}));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var id = jsonResponse['data']['id'];
        getRuleDetails(id.toString());
        _enableEditing.value = false;
      }
      _loading.value = false;
    } catch (error) {
      _loading.value = false;
      Get.snackbar(
        'Rule update error:',
        '$error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // CREATE RULE
  void createRule() async {
    _loading.value = true;
    try {
      final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
      final response = await http.post(Uri.parse(baseUrl),
          headers: headers,
          body: jsonEncode({"house_rules": _ruleData.value.toMap()}));

      if (response.statusCode == 200) backNavigation();

      _loading.value = false;
    } catch (error) {
      _loading.value = false;
      Get.snackbar(
        'Create rule error:',
        '$error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // DELETE RULE
  void deleteRule() async {
    _loading.value = true;
    try {
      final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
      final response = await http.delete(
          Uri.parse('$baseUrl/${_ruleData.value.id}'),
          headers: headers);

      if (response.statusCode == 200) backNavigation();

      _loading.value = false;
    } catch (error) {
      _loading.value = false;
      Get.snackbar(
        'Rule delete error:',
        '$error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
