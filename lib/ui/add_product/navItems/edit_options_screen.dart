import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/add_product/add_product_bloc.dart';
import 'package:sera/ui/add_product/navItems/add_options_screen.dart';
import 'package:sera/ui/common/app_bar.dart';
import 'package:sera/ui/common/app_button.dart';
import 'package:sera/ui/common/app_text_field.dart';
import 'package:sera/util/app_strings.dart';

class EditOptionScreen extends StatefulWidget {
  final int index;
  final ProductOption option;
  const EditOptionScreen(
      {super.key, required this.index, required this.option});

  @override
  _EditOptionScreenState createState() => _EditOptionScreenState();
}

class _EditOptionScreenState extends State<EditOptionScreen> {
  late TextEditingController nameController;
  late List<TextEditingController> valueControllers;
  late List<TextEditingController> quantityControllers;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.option.name);
    valueControllers = widget.option.productOptionStockItems
        .map((item) => TextEditingController(text: item.value))
        .toList();
    quantityControllers = widget.option.productOptionStockItems
        .map((item) => TextEditingController(text: item.quantity.toString()))
        .toList();
  }

  @override
  void dispose() {
    nameController.dispose();
    for (var controller in valueControllers) {
      controller.dispose();
    }
    for (var controller in quantityControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void addStockItem() {
    setState(() {
      valueControllers.add(TextEditingController());
      quantityControllers.add(TextEditingController());
    });
  }

  void removeStockItem(int index) {
    setState(() {
      valueControllers.removeAt(index);
      quantityControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final bloc = context.read<AddProductBloc>();

    return Scaffold(
      appBar: CustomAppBar(
        isbottom: true,
        iscenterTitle: true,
        backgroundColor: theme.colorScheme.onPrimary,
        elevation: 1,
        title: Text(
          'Edit Option',
          style: theme.textTheme.titleLarge!.copyWith(
              color: theme.colorScheme.secondary,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: theme.colorScheme.secondary,
            size: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(AppStrings.OPTION_NAME,
                    style: theme.textTheme.titleMedium)),
            AppTextField(
                isError: false,
                controller: nameController,
                textInputAction: TextInputAction.next,
                onChanged: (String? value) {
                  if (value == null) return;
                  // if (value.isNotEmpty && state.firstNameValidate) {
                  //   bloc.updateFirstNameValidate(false, '');
                  // }
                },
                hint: AppStrings.ENTER_OPTION_NAME,
                textInputType: TextInputType.name,
                radius: 8),
            const SizedBox(height: 20),
            Text('Stock Items', style: theme.textTheme.titleMedium),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: valueControllers.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                        child: AppTextField(
                            isError: false,
                            textInputAction: TextInputAction.next,
                            controller: valueControllers[index],
                            hint: 'Value',
                            textInputType: TextInputType.name,
                            radius: 8)),
                    const SizedBox(width: 5),
                    Expanded(
                        child: AppTextField(
                            isError: false,
                            textInputAction: TextInputAction.done,
                            controller: quantityControllers[index],
                            hint: 'QTY',
                            textInputType: TextInputType.number,
                            radius: 8)),
                    const SizedBox(width: 5),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: addStockItem,
                  child: Container(
                    decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.add,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              width: context.mediaSize.width,
              child: AppButton(
                textColor: Colors.white,
                fontSize: 16,
                borderRadius: 8,
                color: theme.colorScheme.primary,
                text: 'Save Option',
                onClick: () {
                  final updatedStockItems =
                      List<ProductOptionStockItem>.generate(
                    valueControllers.length,
                    (index) => ProductOptionStockItem(
                      value: valueControllers[index].text,
                      quantity:
                          int.tryParse(quantityControllers[index].text) ?? 0,
                    ),
                  );
                  ProductOption updatedOption = ProductOption(
                      name: nameController.text,
                      productOptionStockItems: updatedStockItems,
                      isEnabled: true);
                  bloc.updateProductOption(widget.index, updatedOption);
                  Navigator.pop(context, updatedOption);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
