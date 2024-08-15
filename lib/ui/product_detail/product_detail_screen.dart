import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/cart/cart_screen.dart';
import 'package:sera/ui/common/app_bar.dart';
import 'package:sera/ui/common/app_button.dart';
import 'package:sera/ui/product_detail/product_detail_bloc.dart';
import 'package:sera/ui/product_detail/product_detail_state.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';



class ProductDetail extends StatefulWidget {
  static const String route = "product_detail_screen";
  final int? productId;
  ProductDetail({super.key, this.productId});
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductDetailBloc>().productById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final bloc = context.read<ProductDetailBloc>();
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: CustomAppBar(
        isbottom: true,
        elevation: 0.0,
        backgroundColor: theme.colorScheme.onPrimary,
        iscenterTitle: true,
        title: Text(
          AppStrings.PRODUCT_DETAILS,
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
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(child: Image.asset('assets/3x/cart.png')),
          )
        ],
        onActionPressed: () {
          Navigator.pushNamed(context, CartScreen.route);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ProductDetailBloc, ProductDetailState>(
                builder: (context, state) {
              final data = state.productDetail;
              if (data is Data) {
                final productData = data.data as Product;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "$pictureUrl${productData.appUser!.profileImage!}"),
                  ),
                  title: Text(
                    "${productData.appUser!.firstName!} ${productData.appUser!.lastName!}",
                    style: theme.textTheme.titleLarge!.copyWith(
                        fontSize: 12,
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    "Just Now",
                    style: theme.textTheme.bodySmall!.copyWith(
                        fontSize: 12,
                        color: theme.colorScheme.secondaryContainer,
                        fontWeight: FontWeight.w400),
                  ),
                );
              } else {
                return const SizedBox();
              }
            }),
            BlocBuilder<ProductDetailBloc, ProductDetailState>(
                builder: (context, state) {
              final data = state.productDetail;
              if (data is Data) {
                final productData = data.data as Product;
                return Image.network(
                  '$pictureUrl${productData.imageUrl!}',
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              } else {
                return const SizedBox();
              }
            }),
            BlocBuilder<ProductDetailBloc, ProductDetailState>(
                builder: (context, state) {
              final data = state.productDetail;
              if (data is Data) {
                final productData = data.data as Product;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productData.name!,
                                style: theme.textTheme.titleMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: theme.colorScheme.secondary),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'PREPARATION TIME :${productData.preparationTime} ${productData.preparationUnit}',
                                style: theme.textTheme.bodySmall!.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: theme.colorScheme.secondary
                                        .withOpacity(0.4)),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Image.asset("assets/3x/share.png"),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                child: Icon(
                                  size: 28,
                                  Icons.favorite,
                                  color: theme.colorScheme.error,
                                ),
                                onTap: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text:
                                    productData.info!,
                                style: theme.textTheme.bodySmall!.copyWith(
                                    fontSize: 12,
                                    fontFamily: BaseConstant.poppinsSemibold,
                                    fontWeight: FontWeight.w400),
                                children: [
                                  // TextSpan(
                                  //   text: ' -view more',
                                  //   style: theme.textTheme.bodySmall!.copyWith(
                                  //       fontSize: 8,
                                  //       color: theme.colorScheme.secondary
                                  //           .withOpacity(0.4),
                                  //       fontWeight: FontWeight.w400),
                                  //   recognizer: TapGestureRecognizer()
                                  //     ..onTap = () {},
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: theme.colorScheme.onSecondary),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${productData.cost} kd',
                                style: theme.textTheme.bodySmall!.copyWith(
                                    fontSize: 12,
                                    fontFamily: BaseConstant.poppinsSemibold,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Divider(
                        color: theme.colorScheme.secondaryContainer,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.SIZE,
                            style: theme.textTheme.bodySmall!.copyWith(
                                fontSize: 14,
                                fontFamily: BaseConstant.poppinsSemibold,
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: theme.colorScheme.onSecondary),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppStrings.SIZE_CHART,
                                style: theme.textTheme.bodySmall!.copyWith(
                                    fontSize: 12,
                                    fontFamily: BaseConstant.poppinsSemibold,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        children: ['S', 'M', 'L', 'XL', 'XXL'].map((size) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: BlocBuilder<ProductDetailBloc,
                                ProductDetailState>(builder: (context, state) {
                              return GestureDetector(
                                onTap: () {
                                  bloc.updateSizeIndex(size);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5,
                                          color: theme
                                              .colorScheme.primaryContainer),
                                      color: state.sizeIndex == size
                                          ? BaseConstant.signupSliderColor
                                          : theme.colorScheme.onTertiary,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15.0),
                                    child: Text(
                                      size,
                                      style: theme.textTheme.bodySmall!
                                          .copyWith(
                                              fontSize: 12,
                                              fontFamily:
                                                  BaseConstant.poppinsSemibold,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Length',
                        style: theme.textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                            fontFamily: BaseConstant.poppinsSemibold,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        children:
                            ['52', '54', '56', '58', '60', '62'].map((length) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 12.0, top: 3, bottom: 3),
                            child: BlocBuilder<ProductDetailBloc,
                                ProductDetailState>(builder: (context, state) {
                              return GestureDetector(
                                onTap: () {
                                  bloc.updateLengthIndex(length);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5,
                                          color: theme
                                              .colorScheme.primaryContainer),
                                      color: state.lengthIndex == length
                                          ? BaseConstant.signupSliderColor
                                          : theme.colorScheme.onTertiary,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15.0),
                                    child: Text(
                                      length,
                                      style: theme.textTheme.bodySmall!
                                          .copyWith(
                                              fontSize: 12,
                                              fontFamily:
                                                  BaseConstant.poppinsSemibold,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: AppButton(
                          borderRadius: 8,
                          color: theme.colorScheme.primary,
                          onClick: () {
                            Navigator.pushNamed(context, CartScreen.route);
                          },
                          text: 'Add To Cart',
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            }),
          ],
        ),
      ),
    );
  }
}
