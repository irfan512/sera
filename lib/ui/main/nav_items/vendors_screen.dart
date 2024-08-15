import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/common/search_text_field.dart';
import 'package:sera/ui/main/main_bloc.dart';
import 'package:sera/ui/main/main_state.dart';
import 'package:sera/util/app_strings.dart';


class VendorsListScreen extends StatelessWidget {
  static const String key_title = '/vendors_search_screen';
  const VendorsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final bloc = context.read<MainScreenBloc>();
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      builder: (context, state) {
        final data = state.filtersVendorData;
        final data2 = state.vendorsData;
        if (data is Data) {
          final vendorsList = data.data as List<UserDataModel>;
          return vendorsList.isNotEmpty
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      BlocBuilder<MainScreenBloc, MainScreenState>(
                        builder: (_, state) => SearchTextField(
                          onChanged: (String? value) {
                            if (value == null) return;
                          },
                          textInputAction: TextInputAction.done,
                          hint: AppStrings.SEARCH,
                          textInputType: TextInputType.name,
                          textEditingController: bloc.searchController,
                          onSubmitted: (String? value) {
                            if (value == null || value.isEmpty) {
                              bloc.clearSearch();
                            } else {
                              bloc.searchVendors(value);
                            }
                          },
                          suffixIcon: bloc.searchController.text.isNotEmpty
                              ? InkWell(
                                  child: Icon(Icons.clear,
                                      color: theme.colorScheme.secondary),
                                  onTap: () {
                                    bloc.clearSearch();
                                  },
                                )
                              : const SizedBox(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<MainScreenBloc, MainScreenState>(
                        builder: (context, state) {
                          return vendorsList.isNotEmpty
                              ? GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 0.8,
                                  ),
                                  itemCount: vendorsList.length,
                                  itemBuilder: (context, index) {
                                    return PersonCard(
                                        person: vendorsList[index]);
                                  },
                                )
                              : const Column(
                                  children: [],
                                );
                        },
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlocBuilder<MainScreenBloc, MainScreenState>(
                        builder: (_, state) => SearchTextField(
                          onChanged: (String? value) {
                            if (value == null) return;
                          },
                          textInputAction: TextInputAction.done,
                          hint: AppStrings.SEARCH,
                          textInputType: TextInputType.name,
                          textEditingController: bloc.searchController,
                          onSubmitted: (String? value) {
                            if (value == null || value.isEmpty) {
                              bloc.clearSearch();
                            } else {
                              bloc.searchVendors(value);
                            }
                          },
                          suffixIcon: bloc.searchController.text.isNotEmpty
                              ? InkWell(
                                  child: Icon(Icons.clear,
                                      color: theme.colorScheme.secondary),
                                  onTap: () {
                                    bloc.clearSearch();
                                  },
                                )
                              : const SizedBox(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No Search Vendors Found!",
                              style: theme.textTheme.labelMedium!.copyWith(
                                  fontSize: 12,
                                  color: theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        } else if (data2 is Data) {
          final vendorsList = data2.data as List<UserDataModel>;
          return vendorsList.isNotEmpty
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      BlocBuilder<MainScreenBloc, MainScreenState>(
                        builder: (_, state) => SearchTextField(
                          onChanged: (String? value) {
                            if (value == null) return;
                          },
                          textInputAction: TextInputAction.search,
                          hint: AppStrings.SEARCH,
                          textInputType: TextInputType.name,
                          textEditingController: bloc.searchController,
                          onSubmitted: (String? value) {
                            if (value == null || value.isEmpty) {
                              bloc.clearSearch();
                            } else {
                              bloc.searchVendors(value);
                            }
                          },
                          suffixIcon: bloc.searchController.text.isNotEmpty
                              ? InkWell(
                                  child: Icon(Icons.clear,
                                      color: theme.colorScheme.secondary),
                                  onTap: () {
                                    bloc.clearSearch();
                                  },
                                )
                              : const SizedBox(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<MainScreenBloc, MainScreenState>(
                        builder: (context, state) {
                          return vendorsList.isNotEmpty
                              ? GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 0.8,
                                  ),
                                  itemCount: vendorsList.length,
                                  itemBuilder: (context, index) {
                                    return PersonCard(
                                        person: vendorsList[index]);
                                  },
                                )
                              : const Column(
                                  children: [],
                                );
                        },
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlocBuilder<MainScreenBloc, MainScreenState>(
                        builder: (_, state) => SearchTextField(
                          onChanged: (String? value) {
                            if (value == null) return;
                          },
                          textInputAction: TextInputAction.done,
                          hint: AppStrings.SEARCH,
                          textInputType: TextInputType.name,
                          textEditingController: bloc.searchController,
                          onSubmitted: (String? value) {
                            if (value == null || value.isEmpty) {
                              bloc.clearSearch();
                            } else {
                              bloc.searchVendors(value);
                            }
                          },
                          suffixIcon: InkWell(
                            child: Icon(Icons.clear,
                                color: theme.colorScheme.secondary),
                            onTap: () {
                              bloc.clearSearch();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No Search Vendors Found!",
                              style: theme.textTheme.labelMedium!.copyWith(
                                  fontSize: 12,
                                  color: theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: theme.colorScheme.primary,
            ),
          );
        }
      },
    );
  }
}

class PersonCard extends StatelessWidget {
  final UserDataModel person;

  const PersonCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      children: [
        person.profileImage!.isNotEmpty
            ? Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: NetworkImage(
                              "$pictureUrl${person.profileImage!}"),
                          fit: BoxFit.cover)),
                ),
              )
            : Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                          image: AssetImage(
                              "assets/Profile_avatar_placeholder_large.png"),
                          fit: BoxFit.cover)),
                ),
              ),
        const SizedBox(height: 8.0),
        Text(
          "${person.firstName} ${person.lastName}",
          style: theme.textTheme.labelMedium!.copyWith(
              fontSize: 12,
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
