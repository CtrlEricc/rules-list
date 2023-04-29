import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rules/constants.dart';
import 'package:rules/controllers/list_controller.dart';
import 'package:rules/views/widgets/pagination_widget.dart';
import 'package:rules/views/widgets/rule_card.dart';

import '../../models/rule_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ListController _listController;

  @override
  void initState() {
    _listController = ListController();
    _listController.getRules();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => Stack(
            children: [
              Image.asset(
                'assets/images/home_background.jpg',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 120),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: _listController.loading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: orange_500,
                        ))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset('assets/images/logo.png',
                                      width: 40),
                                  Text(
                                    'your house rules',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: orange_600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: PaginationWidget(
                                currentPage: _listController.currentPage,
                                onPressNext: _listController.nextPage(),
                                onPressPrev: _listController.prevPage(),
                                totalPages: _listController.totalPages,
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: _listController.listRules.length,
                                itemBuilder: (context, index) {
                                  final Rule item =
                                      _listController.listRules[index];
                                  return RuleCard(item: item);
                                },
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: FloatingActionButton(
            onPressed: () =>
                Get.offNamed('/rule', arguments: {'preSettedValues': false}),
            backgroundColor: orange_600,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
