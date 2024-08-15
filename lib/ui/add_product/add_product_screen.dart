import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/add_product/add_product_bloc.dart';
import 'package:sera/ui/add_product/add_product_state.dart';
import 'package:sera/ui/add_product/navItems/add_options_screen.dart';
import 'package:sera/ui/add_product/navItems/finance_screen.dart';
import 'package:sera/ui/add_product/navItems/inventory_screen.dart';
import 'package:sera/ui/add_product/navItems/products_screen.dart';
import 'package:sera/ui/common/app_bar.dart';
import 'package:sera/util/app_strings.dart';

class AddProductScreen extends StatefulWidget {
  static const String route = '/addProduct_main_screen_route';
  const AddProductScreen({
    super.key,
  });

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final pageSliderIndexedMap = <PageStorageKey<String>, Widget>{};
  static const _productScreenNavigationKey =
      PageStorageKey(ProductsScreen.key_title);
  static const _financeScreenNavigationKey =
      PageStorageKey(FinanceScreem.key_title);
  static const _inventoryScreenNavigationKey =
      PageStorageKey(Inventory.key_title);
  static const _optionScreenNavigationKey =
      PageStorageKey(AddOptionsScreen.key_title);

  @override
  void initState() {

    pageSliderIndexedMap[_productScreenNavigationKey] =
        const ProductsScreen(key: _productScreenNavigationKey);
    pageSliderIndexedMap[_financeScreenNavigationKey] =
        const FinanceScreem(key: _financeScreenNavigationKey);
    pageSliderIndexedMap[_inventoryScreenNavigationKey] =
        const Inventory(key: _inventoryScreenNavigationKey);
    pageSliderIndexedMap[_optionScreenNavigationKey] =
        const AddOptionsScreen(key: _optionScreenNavigationKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final bloc = context.read<AddProductBloc>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: CustomAppBar(
        isbottom: true,
        iscenterTitle: true,
        backgroundColor: theme.colorScheme.onPrimary,
        elevation: 1,
        title: BlocBuilder<AddProductBloc, AddProductState>(
            builder: (context, state) {
          return state.pagerIndex == 3
              ? Text(
                  AppStrings.ADD_OPTION,
                  style: theme.textTheme.titleLarge!.copyWith(
                      color: theme.colorScheme.secondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                )
              : Text(
                  AppStrings.ADD_PRODUCT,
                  style: theme.textTheme.titleLarge!.copyWith(
                      color: theme.colorScheme.secondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                );
        }),
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
      body: PageView.builder(
          controller: bloc.pageSliderController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (int? index) {
            if (index == null) return;
            final pageStorageKey = pageSliderIndexedMap.keys.elementAt(index);
            final pagerItem = pageSliderIndexedMap[pageStorageKey];
            if (pagerItem == null || pagerItem is SizedBox) {
              final newPagerWidget = _getNavigationWidget(index);
              pageSliderIndexedMap[pageStorageKey] = newPagerWidget;
            }
            bloc.updatePagerIndex(index);
          },
          itemBuilder: (_, index) {
            return BlocBuilder<AddProductBloc, AddProductState>(
                buildWhen: (previous, current) =>
                    previous.pagerIndex != current.pagerIndex,
                builder: (_, state) {
                  state.pagerIndex;
                  return IndexedStack(
                      index: index,
                      children: pageSliderIndexedMap.values.toList());
                });
          },
          scrollDirection: Axis.horizontal,
          itemCount: 4),
    );
  }

  Widget _getNavigationWidget(int index) {
    switch (index) {
      case 0:
        return const ProductsScreen(key: _productScreenNavigationKey);
      case 1:
        return const FinanceScreem(key: _financeScreenNavigationKey);
      case 2:
        return const Inventory(key: _inventoryScreenNavigationKey);
      case 3:
        return const AddOptionsScreen(key: _optionScreenNavigationKey);

      default:
        return const SizedBox();
    }
  }
}
