import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/common/search_text_field.dart';
import 'package:sera/ui/main/main_bloc.dart';
import 'package:sera/ui/main/main_state.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';



class SearchScreen extends StatelessWidget {
  static const String key_title = 'search_screen';
  const SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final size = context.mediaSize;
    final bloc = context.read<MainScreenBloc>();
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<MainScreenBloc, MainScreenState>(
                  builder: (_, state) => SearchTextField(
                        onChanged: (String? value) {
                          if (value == null) return;
                        },
                        textInputAction: TextInputAction.done,
                        hint: AppStrings.SEARCH,
                        suffixIcon: PopupMenuButton<int>(
                          color: Colors.white,
                          shadowColor: Colors.transparent,
                          offset: const Offset(0, 40),
                          elevation: 0,
                          tooltip: '',
                          splashRadius: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(minWidth: 120),
                          position: PopupMenuPosition.over,
                          itemBuilder: (context) {
                            return bloc.productFilterList.entries
                                .map((MapEntry<int, String> entry) {
                              return PopupMenuItem<int>(
                                  value: entry.key,
                                  child: Text(entry.value,
                                      style:
                                          theme.textTheme.titleSmall!.copyWith(
                                        fontSize: 15,
                                        color: theme.colorScheme.secondary,
                                      )));
                            }).toList();
                          },
                          onSelected: (selectedUserType) {
                            bloc.orderStatusController.text =
                                bloc.orderStatusList[selectedUserType] ??
                                    'None';
                            bloc.updateOrderSelectedIndex(selectedUserType);
                          },
                          child: Image.asset(
                            "assets/3x/search_filter.png",
                          ),
                        ),
                        textInputType: TextInputType.name,
                        textEditingController: bloc.filterSearchController,
                      )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 30,
                width: size.width,
                child: BlocBuilder<MainScreenBloc, MainScreenState>(
                    builder: (context, state) {
                  return Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            bloc.updateFilterIndexValue(0);
                            bloc.filterProductsByCategory(0);
                          },
                          child: Container(
                              height: 23,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11.5),
                                border: Border.all(
                                    width: 0.5,
                                    color: theme.colorScheme.primaryContainer),
                                color: state.filterIndex == 0
                                    ? BaseConstant.signupSliderColor
                                    : const Color(0xfff8f8f7),
                              ),
                              child: Center(
                                  child: Text(
                                "All",
                                style: theme.textTheme.labelMedium!.copyWith(
                                    color: theme.colorScheme.secondary,
                                    fontWeight: state.filterIndex == 0
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                    fontSize: 12),
                              )))),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: state.allCategories.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: BlocBuilder<MainScreenBloc,
                                    MainScreenState>(builder: (context, state) {
                                  return GestureDetector(
                                    onTap: () {
                                      bloc.updateFilterIndexValue(index + 1);
                                      bloc.filterProductsByCategory(
                                          state.allCategories[index + 1].id);
                                    },
                                    child: Container(
                                      height: 23,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(11.5),
                                        border: Border.all(
                                            width: 0.5,
                                            color: theme
                                                .colorScheme.primaryContainer),
                                        color: state.filterIndex == index + 1
                                            ? BaseConstant.signupSliderColor
                                            : const Color(0xfff8f8f7),
                                      ),
                                      child: Center(
                                        child: Text(
                                          state.allCategories[index].name
                                              .trim()
                                              .substring(
                                                  0,
                                                  state.allCategories[index]
                                                              .name
                                                              .trim()
                                                              .length >
                                                          7
                                                      ? 7
                                                      : state
                                                          .allCategories[index]
                                                          .name
                                                          .trim()
                                                          .length),
                                          style: theme.textTheme.labelMedium!
                                              .copyWith(
                                                  color: theme
                                                      .colorScheme.secondary,
                                                  fontWeight:
                                                      state.filterIndex ==
                                                              index + 1
                                                          ? FontWeight.w500
                                                          : FontWeight.w400,
                                                  fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                            }),
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<MainScreenBloc, MainScreenState>(
                  builder: (context, state) {
                final data = state.filteredProductsData;
                if (data is Loading) {
                  return const CircularProgressIndicator();
                } else if (data is Data) {
                  final allproducts = data.data as List<Product>;
                  return allproducts.isNotEmpty
                      ? MasonryGridView.builder(
                          gridDelegate:
                              const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: allproducts.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          "$pictureUrl${allproducts[index].imageUrl!}",
                                          fit: BoxFit.cover,
                                        ))));
                          })
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: size.height * .25,
                            ),
                            Text(
                              "No Products Found!",
                              style: theme.textTheme.labelMedium!.copyWith(
                                  fontSize: 12,
                                  color: theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        );
                } else {
                  return const SizedBox();
                }
              }),
            ]));
  }
}
