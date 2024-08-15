// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/material_dailog_content.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/data/snackbar_message.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/helper/dialog_helper.dart';
import 'package:sera/helper/snackbar_helper.dart';
import 'package:sera/ui/add_story_post/add_story_post_screen_bloc.dart';
import 'package:sera/ui/add_story_post/add_story_post_screen_state.dart';
import 'package:sera/ui/common/app_bar.dart';
import 'package:sera/ui/common/app_button.dart';
import 'package:sera/ui/main/main_screen.dart';
import 'package:sera/util/app_strings.dart';

class ConnectProduct extends StatelessWidget {
  static const String route = "connect_product_screen";
  final String imagePath;
  final String videoPath; 
  final bool? isStory;
 const ConnectProduct({super.key, 
  this.isStory,
 this.imagePath='',  this.videoPath=''});

  DialogHelper get _dialogHelper => DialogHelper.instance();
  SnackbarHelper get _snackbarHelper => SnackbarHelper.instance();


  Future<void> _addPost(AddStoryPostBloc bloc, BuildContext context,
      DialogHelper dialogHelper) async {
    dialogHelper
      ..injectContext(context)
      ..showProgressDialog(AppStrings.LOADING);
    try {
      final response = await bloc.addpost(imagePath: imagePath,videoPath: videoPath);
      dialogHelper.dismissProgress();
      if (response.status != true) {
        _snackbarHelper
          ..injectContext(context)
          ..showSnackbar(
              snackbarMessage:
                  SnackbarMessage.smallMessageError(content: response.message),
              margin: EdgeInsets.only(
                  left: 25,
                  right: 25,
                  bottom: context.isHaveBottomNotch ? 100 : 90));
        return;
      }
      _snackbarHelper
        ..injectContext(context) 
        ..showSnackbar(
            snackbarMessage:
                SnackbarMessage.smallMessage(content: response.message),
            margin: EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: context.isHaveBottomNotch ? 100 : 90));
                Navigator.pushNamedAndRemoveUntil(context, MainScreen.route, (route) => false);
    } catch (_) {
      dialogHelper.dismissProgress();
      dialogHelper.showTitleContentDialog(MaterialDialogContent.networkError(),
          () => _addPost(bloc, context, dialogHelper));
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final bloc = context.read<AddStoryPostBloc>();
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: CustomAppBar(
          isbottom: true,
          elevation: 0.0,
          backgroundColor: theme.colorScheme.onPrimary,
          iscenterTitle: true,
          title: Text('Select Product',
              style: theme.textTheme.titleLarge!.copyWith(
                  color: theme.colorScheme.secondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back_ios,
                  color: theme.colorScheme.secondary, size: 20)),
          onLeadingPressed: () => Navigator.pop(context)),
      body: BlocBuilder<AddStoryPostBloc, AddStoryPostState>(
        builder: (context, state) {
          final data = state.productData;
          if (data is Data) {
            final productList = data.data as List<Product>;
            return productList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                              itemCount: productList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: ListTile(
                                      leading: Image.network(
                                        width: 100,
                                        "$pictureUrl${productList[index].imageUrl!}",
                                        fit: BoxFit.contain,
                                      ),
                                      title: Text(productList[index].name!,
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                                  color: theme
                                                      .colorScheme.secondary,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                      trailing: Checkbox(
                                          value: bloc.state.selectProductId ==
                                              productList[index].id,
                                          onChanged: (bool? value) {
                                            bloc.updateSelectedProduct(
                                                productList[index].id);
                                          })),
                                );
                              }),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width * .6,
                            child: AppButton(
                                textColor: Colors.white,
                                fontSize: 16,
                                borderRadius: 8,
                                color: theme.colorScheme.primary,
                                text: AppStrings.POST,
                                onClick: () {
                                  context.unfocus();
                                  if (bloc.state.selectProductId != 0) {
                                    _addPost(bloc, context, _dialogHelper);
                                  } else {
                                    _snackbarHelper
                                      ..injectContext(context)
                                      ..showSnackbar(
                                          snackbarMessage: const SnackbarMessage
                                              .smallMessageError(
                                              content: "Select Product"),
                                          margin: EdgeInsets.only(
                                              left: 25,
                                              right: 25,
                                              bottom: context.isHaveBottomNotch
                                                  ? 100
                                                  : 90));
                                  }
                                })),
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "No Products Found!",
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
