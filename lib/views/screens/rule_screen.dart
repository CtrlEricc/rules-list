import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rules/constants.dart';
import 'package:rules/controllers/rule_controller.dart';

class RuleScreen extends StatefulWidget {
  final id = Get.arguments['id'];
  final preSettedValues = Get.arguments['preSettedValues'];

  RuleScreen({super.key});

  @override
  State<RuleScreen> createState() => _RuleScreenState();
}

class _RuleScreenState extends State<RuleScreen> {
  late final RuleController _ruleController;

  @override
  void initState() {
    _ruleController = RuleController();
    if (widget.preSettedValues) {
      _ruleController.setLoading(true);
      _ruleController.getRuleDetails(widget.id.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _ruleController.backNavigation();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.preSettedValues ? 'Rule details' : 'Create new rule',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: orange_600,
              ),
            ),
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            leading: IconButton(
                onPressed: () => _ruleController.backNavigation(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: orange_600,
                )),
            actions: [
              if (widget.preSettedValues) ...[
                IconButton(
                  onPressed: () => _ruleController.enableEdit(),
                  icon: const Icon(
                    Icons.edit,
                    color: orange_600,
                  ),
                ),
                IconButton(
                  onPressed: () => _ruleController.deleteRule(),
                  icon: const Icon(
                    Icons.delete,
                    color: orange_600,
                  ),
                ),
              ]
            ],
          ),
          body: Obx(() {
            return _ruleController.loading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: orange_500,
                  ))
                : Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          onChanged: (name) =>
                              _ruleController.setRuleName(name),
                          controller: TextEditingController(
                              text: _ruleController.ruleData.name),
                          enabled: _ruleController.enableEditing ||
                              !widget.preSettedValues,
                          decoration: InputDecoration(
                            labelText: 'Rule name',
                            labelStyle: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (widget.preSettedValues &&
                            !_ruleController.enableEditing)
                          Text(
                            _ruleController.ruleData.active != 0
                                ? 'Rule activated'
                                : 'Rule deactivated',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: orange_500),
                          ),
                        if (_ruleController.enableEditing ||
                            !widget.preSettedValues) ...[
                          SwitchListTile(
                            title: Text(
                              'Active or deactive rule',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500),
                            ),
                            value: _ruleController.ruleData.active != 0,
                            onChanged: (value) {
                              _ruleController.setActiveSwitch(value);
                              setState(() {});
                            },
                            activeColor: orange_500,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: orange_700,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0))),
                                onPressed: () => widget.preSettedValues
                                    ? _ruleController.updateRuleDetails()
                                    : _ruleController.createRule(),
                                child: Text(
                                  'SAVE',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500),
                                )),
                          )
                        ]
                      ],
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
