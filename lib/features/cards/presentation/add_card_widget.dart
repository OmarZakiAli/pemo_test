import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:test_repo/features/cards/domain/bloc/cards_bloc.dart';
import 'package:test_repo/theme/app_buttons.dart';
import 'package:test_repo/theme/input_decorations.dart';

class AddCardWidget extends StatefulWidget {
  const AddCardWidget({super.key});

  @override
  State<AddCardWidget> createState() => _AddCardWidgetState();
}

class _AddCardWidgetState extends State<AddCardWidget> {
  final _formKey = GlobalKey<FormBuilderState>();
  int currentStep = 0;
  final List<String> fakeNames = ["Naser Mansi", "Mo Salah", "Vini Junior"];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            "Add card",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    EasyStepper(
                        disableScroll: true,
                        showScrollbar: false,
                        activeStep: currentStep,
                        steps: [
                          EasyStep(
                              title: "Card data",
                              icon: Icon(
                                Icons.credit_card,
                              )),
                          EasyStep(title: "Balance", icon: Icon(Icons.wallet)),
                          EasyStep(
                              title: "Color", icon: Icon(Icons.color_lens)),
                        ]),
                    SizedBox(
                      height: 8,
                    ),
                    if (currentStep == 0) _buildCardInfo(),
                    if (currentStep == 1) _buildBalanceField(),
                    if (currentStep == 2) _buildColorField(),
                  ],
                ),
              ),
            ),
          ),
          _buildFormActions(),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  _buildCardInfo() {
    return Column(
      children: [
        FormBuilderTextField(
          name: "card_name",
          key: ValueKey("card_name"),
          decoration: InputDecorations.defaultDecoration(label: "Card name"),
          validator: FormBuilderValidators.minLength(3,
              errorText: "Card name must be at least 3 characters long"),
        ),
        SizedBox(
          height: 16,
        ),
        FormBuilderDropdown(
          name: "holder_name",
          key: ValueKey("holder_name"),
          decoration: InputDecorations.defaultDecoration(
            label: "Holder name",
          ),
          hint: Text(
            "Select card holder",
          ),
          validator: FormBuilderValidators.required(),
          items: [
            ...fakeNames.map((e) => DropdownMenuItem(value: e, child: Text(e)))
          ],
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  _buildBalanceField() {
    return Column(
      children: [
        FormBuilderTextField(
          name: "balance",
          key: ValueKey("balance"),
          decoration: InputDecorations.defaultDecoration(
              label: "Card Balance",
              hintText: "Enter a number between 100 and 1000"),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3),
          ],
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.min(100,
                errorText: "Balance must be at least 100"),
            FormBuilderValidators.max(1000,
                errorText: "Balance not exceed 1000"),
          ]),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  _buildColorField() {
    return Column(
      children: [
        FormBuilderColorPickerField(
          name: "color",
          colorPickerType: ColorPickerType.materialPicker,
          initialValue: Colors.blue,
          decoration: InputDecorations.defaultDecoration(
              label: "Card Color", hintText: "Pick a color"),
          validator: FormBuilderValidators.required(),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _buildFormActions() {
    if (currentStep == 2) {
      return PrimaryButton(
          onTap: () async {
            if (_formKey.currentState!.saveAndValidate() == true) {
              final data = _formKey.currentState!.value;

              await GetIt.instance.get<CardsBloc>().addCard(
                  name: data["card_name"],
                  color: data["color"],
                  holderName: data["holder_name"],
                  balance: int.parse(data["balance"]));
              if (mounted) {
                Navigator.of(context).pop();
              }
            }
          },
          title: "Confirm");
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (currentStep != 0) ...[
          PrimaryButton(
              title: "Back",
              onTap: () {
                setState(() {
                  currentStep = currentStep - 1;
                });
              }),
          SizedBox(
            width: 12,
          ),
        ],
        PrimaryButton(
          title: "Next",
          onTap: () {
            if (_formKey.currentState?.saveAndValidate() == true) {
              setState(() {
                currentStep++;
              });
            }
          },
        ),
      ],
    );
  }
}
