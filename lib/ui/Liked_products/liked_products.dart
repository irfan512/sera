import 'package:flutter/material.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/common/app_bar.dart';
import 'package:sera/util/app_strings.dart';

class LikedProducts extends StatelessWidget {
  static const String route = 'liked_products_screen';
  const LikedProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        isbottom: true,
        elevation: 0.0,
        backgroundColor: theme.colorScheme.onPrimary,
        iscenterTitle: true,
        title: Text(
          AppStrings.LIKED_PRODUCTS,
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
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 10,
          ),
          // MasonryGridView.builder(
          //   gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //   ),
          //   itemCount: favorite.length,
          //   physics: const NeverScrollableScrollPhysics(),
          //   shrinkWrap: true,
          //   itemBuilder: (_, index) {
          //     return Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Stack(
          //         children: [
          //           Container(
          //             decoration: BoxDecoration(
          //               color: Colors.transparent,
          //               borderRadius: BorderRadius.circular(15),
          //             ),
          //             child: ClipRRect(
          //               borderRadius: BorderRadius.circular(15),
          //               child: Image.asset(
          //                 favorite[index].imageUrl,
          //                 fit: BoxFit.cover,
          //               ),
          //             ),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Align(
          //               alignment: Alignment.topRight,
          //               child: Container(
          //                 decoration: BoxDecoration(
          //                     shape: BoxShape.circle,
          //                     color:
          //                         theme.colorScheme.onPrimary.withOpacity(0.4)),
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(4.0),
          //                   child: Icon(
          //                     Icons.favorite,
          //                     size: 20,
          //                     color: theme.colorScheme.error,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     );
          //   },
          // ),
      
      
      
      
        ]),
      ),
    );
  }
}
