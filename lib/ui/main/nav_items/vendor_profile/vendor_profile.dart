import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/helper/bottom_sheet_helper.dart';
import 'package:sera/ui/business_update%20/business_update_screen.dart';
import 'package:sera/ui/main/main_bloc.dart';
import 'package:sera/ui/main/main_state.dart';
import 'package:sera/ui/product_detail/product_detail_screen.dart';
import 'package:video_player/video_player.dart';

class VendorProfileScreen extends StatelessWidget {
  static const String key_title = '/vendor_profile_screen';
  const VendorProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final bloc = context.read<MainScreenBloc>();
    final size = context.mediaSize;
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
            height: 220,
            width: MediaQuery.sizeOf(context).width,
            child: Stack(children: [
              BlocBuilder<MainScreenBloc, MainScreenState>(
                  builder: (context, state) {
                final data = state.currentUserData;
                if (data is Data) {
                  final userdata = data.data as UserDataModel;
                  return userdata.appUserBrand!.headerUrl != ""
                      ? Container(
                          height: 150,
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '$pictureUrl${userdata.appUserBrand!.headerUrl}'),
                                  fit: BoxFit.cover)))
                      : Container(
                          height: 150,
                          width: MediaQuery.sizeOf(context).width,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/3x/cover-image.png"),
                                  fit: BoxFit.cover)));
                } else {
                  return Container(
                    height: 150,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      image: DecorationImage(
                          image: AssetImage("assets/3x/cover-image.png"),
                          fit: BoxFit.cover),
                    ),
                  );
                }
              }),
              Positioned(
                top: context.isHaveBottomNotch ? 50 : 38,
                left: 15,
                child: GestureDetector(
                    onTap: () {
                      bloc.scaffoldKey.currentState!.openDrawer();
                      context.unfocus();
                    },
                    child: Image.asset(
                      "assets/3x/menu.png",
                      height: 30,
                      width: 30,
                    )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SizedBox(
                      height: 140,
                      child: Stack(
                        children: [
                          BlocBuilder<MainScreenBloc, MainScreenState>(
                              builder: (context, state) {
                            final data = state.currentUserData;
                            if (data is Data) {
                              final userdata = data.data as UserDataModel;
                              return userdata.appUserBrand!.logoUrl != ""
                                  ? Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.secondary,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: theme.colorScheme.onPrimary,
                                            width: 3),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '$pictureUrl${userdata.appUserBrand!.logoUrl}'),
                                            fit: BoxFit.cover),
                                      ))
                                  : Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.secondary,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: theme.colorScheme.onPrimary,
                                            width: 3),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/3x/dummy_user.png'),
                                            fit: BoxFit.cover),
                                      ));
                            } else {
                              return Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.secondary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: theme.colorScheme.onPrimary,
                                        width: 3),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/3x/dummy_user.png'),
                                        fit: BoxFit.cover),
                                  ));
                            }
                          }),
                          Positioned(
                            bottom: 20,
                            right: 10,
                            child: InkWell(
                              onTap: () async {
                                BottomSheetHelper.instance()
                                  ..injectContext(context)
                                  ..showAddPostSheet(context, () {});
                              },
                              child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color: Color(0xffB2BBA6),
                                          shape: BoxShape.circle),
                                      child: const Icon(Icons.add))),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0, bottom: 28.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, EditBrand.route)
                          .then((value) {
                        bloc.getUserFromSharedPref();
                      });
                    },
                    child: Image.asset(
                      'assets/3x/edit_profile.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
              )
            ])),
        BlocBuilder<MainScreenBloc, MainScreenState>(builder: (context, state) {
          final data = state.currentUserData;
          if (data is Data) {
            final userdata = data.data as UserDataModel;
            return Text("${userdata.appUserBrand!.brandName}",
                style: theme.textTheme.titleMedium!
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w500));
          } else {
            return Text("",
                style: theme.textTheme.titleMedium!
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w500));
          }
        }),
        const SizedBox(height: 5),
        BlocBuilder<MainScreenBloc, MainScreenState>(builder: (context, state) {
          final data = state.currentUserData;
          if (data is Data) {
            final userdata = data.data as UserDataModel;
            return Text(
                "${userdata.appUserBrand!.bio} - ${userdata.appUserBrand!.slogan}",
                style: theme.textTheme.titleMedium!.copyWith(
                    fontSize: 14,
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w400));
          } else {
            return Text("",
                style: theme.textTheme.titleMedium!.copyWith(
                    fontSize: 14,
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w400));
          }
        }),
        const SizedBox(height: 20),
        SizedBox(
          height: 40,
          width: size.width,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView.builder(
                itemCount: bloc.vendorProfileItems.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Center(
                    child: BlocBuilder<MainScreenBloc, MainScreenState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            bloc.updateVendorProfileIndex(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: state.vendorProfileItemIndex == index
                                      ? theme.colorScheme.secondary
                                      : theme.colorScheme.primaryContainer,
                                  width: state.vendorProfileItemIndex == index
                                      ? 2.0
                                      : 1.0,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: BlocBuilder<MainScreenBloc,
                                    MainScreenState>(builder: (context, state) {
                                  return Text(
                                    "${index == 0 ? state.postLength : index == 1 ? state.productLength : state.collectionLength} ${bloc.vendorProfileItems[index]}",
                                    style:
                                        theme.textTheme.titleMedium!.copyWith(
                                      color: state.vendorProfileItemIndex ==
                                              index
                                          ? theme.colorScheme.secondary
                                          : theme.colorScheme.primaryContainer,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        BlocBuilder<MainScreenBloc, MainScreenState>(
          builder: (context, state) {
            return state.vendorProfileItemIndex == 0
                ? Posts()
                : state.vendorProfileItemIndex == 1
                    ? Products()
                    : state.vendorProfileItemIndex == 2
                        ? Collections()
                        : const SizedBox();
          },
        ),
      ]),
    );
  }
}

//............................. COLLECTION .................//
class Collections extends StatefulWidget {
  Collections({super.key});

  @override
  State<Collections> createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final size = context.mediaSize;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
        child: BlocBuilder<MainScreenBloc, MainScreenState>(
            builder: (context, state) {
          final data = state.collectionsData;
          if (data is Data) {
            final collectionList = data.data as List<AllCollectionsModel>;
            return Wrap(
              spacing: 10,
              children: [
                for (int i = 0; i < collectionList.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Stack(
                      children: [
                        Container(
                          height: 180,
                          width: size.width * .42,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "$pictureUrl${collectionList[i].imageUrl!}"),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          height: 180,
                          width: size.width * .42,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(
                          height: 180,
                          width: size.width * .42,
                          child: Center(
                            child: Text(
                              collectionList[i].name!,
                              style: theme.textTheme.titleMedium!.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: theme.colorScheme.onPrimary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            );
          } else {
            return const SizedBox();
          }
        }));
  }
}


//............................. PRODUCTS .................//
class Products extends StatelessWidget {
  Products({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final size = context.mediaSize;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
        child: BlocBuilder<MainScreenBloc, MainScreenState>(
            builder: (context, state) {
          final data = state.vendorProducts;
          if (data is Data) {
            final productList = data.data as List<Product>;
            return Wrap(
              spacing: 10,
              children: [
                for (int i = 0; i < productList.length; i++)
                  InkWell(
                    onTap: (){

                     Navigator.pushNamed(context, ProductDetail.route,arguments: productList[i].id); 
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        children: [
                          Container(
                            height: 180,
                            width: size.width * .42,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "$pictureUrl${productList[i].imageUrl!}"),
                                    fit: BoxFit.cover)),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: size.width * .42,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    productList[i].name!,
                                    style: theme.textTheme.titleMedium!.copyWith(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            theme.colorScheme.primaryContainer),
                                  ),
                                  Text(
                                    productList[i].salePrice!.toString(),
                                    style: theme.textTheme.titleMedium!.copyWith(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: theme.colorScheme.secondary),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            );
          } else {
            return const SizedBox();
          }
        }));
  }
}




//............................. POST .................//


// class Posts extends StatefulWidget {
//   Posts({Key? key}) : super(key: key);

//   @override
//   State<Posts> createState() => _PostsState();
// }



// class _PostsState extends State<Posts> {
//   @override
//   Widget build(BuildContext context) {
//     final size = context.mediaSize;
//     final theme = context.theme;

//     return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
//         child: BlocBuilder<MainScreenBloc, MainScreenState>(
//             builder: (context, state) {
//           final data = state.vendorposts;
//           if (data is Data) {
//             final postList = data.data as List<PostModel>;
//             return Wrap(
//               spacing: 10,
//               children: [
//                 for (int i = 0; i < postList.length; i++)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5),
//                     child: postList[i].imageUrl != null
//                         ? Container(
//                             height: 180,
//                             width: size.width * .42,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 image: DecorationImage(
//                                     image: NetworkImage(
//                                         "$pictureUrl${postList[i].imageUrl!}"),
//                                     fit: BoxFit.cover)),
//                           )
//                         : postList[i].imageUrl == null &&
//                                 postList[i].videoUrl == null &&
//                                 postList[i].caption!.isNotEmpty
//                             ? Container(
//                                 height: 180,
//                                 width: size.width * .42,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(8),
//                                   color: const Color(0xffF8F8F7),
//                                   // image: DecorationImage(
//                                   //     image: NetworkImage("$pictureUrl${postList[i].imageUrl!}"),
//                                   //     fit: BoxFit.cover),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Post",
//                                         style: theme.textTheme.titleMedium!
//                                             .copyWith(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: theme
//                                                     .colorScheme.secondary),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       Text(
//                                         postList[i].caption.toString(),
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: theme.textTheme.titleMedium!
//                                             .copyWith(
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: theme
//                                                     .colorScheme.secondary),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             : SizedBox(
//                                 height: 180,
//                                 width: size.width * .42,
//                               ),
//                   ),
//               ],
//             );
//           } else {
//             return const SizedBox();
//           }
//         }));
//   }


//  Widget buildMediaWidget(int index, VideoPlayerControllerProvider value) {
//     final item = widget.data![index];
//     if (isVideoUrl(item.filePath)) {
//       final videoIndex = getVideoIndex(item.filePath, value.videoControllers);
//       if (videoIndex != null) {
//         return _buildVideoPlayerWidget(value, videoIndex);
//       } else {
//         return Container(
//           color: Colors.black,
//         );
//       }
//     } else{
//       return const SizedBox();
//     }
//   }

//   int? getVideoIndex(String filePath, List<VideoPlayerController> controllers) {
//     final videoUrl = '$pictureUrl$filePath';
//     for (int i = 0; i < controllers.length; i++) {
//       final decodedDataSource = Uri.decodeFull(controllers[i].dataSource);
//       if (decodedDataSource == videoUrl) {
//         return i;
//       }
//     }
//     return null;
//   }

//   Widget _buildVideoPlayerWidget(
//       VideoPlayerControllerProvider value, int index) {
//     var controller = value.videoControllers[index];
//     return Stack(
//       children: [
//         AspectRatio(
//           aspectRatio: controller.value.aspectRatio,
//           child: VideoPlayer(controller),
//         ),
//         Align(
//           alignment: Alignment.topLeft,
//           child: InkWell(
//             onTap: () {
//               value.togglePlayPause(index); // Add the correct index parameter
//             },
//             child: Container(
//               decoration: const BoxDecoration(
//                   color: Colors.black26, shape: BoxShape.circle),
//               child: Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Icon(
//                   controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                   color: Colors.white,
//                   size: 32,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   bool isVideoUrl(String url) {
//     return url.toLowerCase().endsWith('.mp4');
//   }



// }






// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:video_player/video_player.dart';

class Posts extends StatefulWidget {
  Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
          final data = state.vendorposts;
          final videoControllers = state.videoControllers;

          if (data is Data) {
            final postList = data.data as List<PostModel>;

            return Wrap(
              spacing: 10,
              children: [
                for (int i = 0; i < postList.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: postList[i].videoUrl != null
                        ? buildMediaWidget(i, videoControllers,postList)
                        : postList[i].imageUrl != null
                            ? Container(
                                height: 180,
                                width: size.width * .42,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "$pictureUrl${postList[i].imageUrl!}"),
                                        fit: BoxFit.cover)),
                              )
                            : postList[i].caption!.isNotEmpty
                                ? Container(
                                    height: 180,
                                    width: size.width * .42,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xffF8F8F7),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Post",
                                            style: theme.textTheme.titleMedium!
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: theme.colorScheme
                                                        .secondary),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            postList[i]
                                                .caption
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: theme.textTheme.titleMedium!
                                                .copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: theme.colorScheme
                                                        .secondary),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 180,
                                    width: size.width * .42,
                                  ),
                  ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
  

  Widget buildMediaWidget(int index, List<VideoPlayerController> controllers,postList) {
    final post = postList![index];
    if (post.videoUrl != null) {
      final videoIndex = getVideoIndex(post.videoUrl!, controllers);

      if (videoIndex != null) {
        return _buildVideoPlayerWidget(controllers[videoIndex]);
      } else {
        return Container(
          height: 180,
          width: MediaQuery.of(context).size.width * .42,
          color: Colors.black,
        );
      }
    } else {
      return const SizedBox();
    }
  }

  int? getVideoIndex(String videoUrl, List<VideoPlayerController> controllers) {
    final fullVideoUrl = '$pictureUrl$videoUrl';
    for (int i = 0; i < controllers.length; i++) {
      final decodedDataSource = Uri.decodeFull(controllers[i].dataSource);
      if (decodedDataSource == fullVideoUrl) {
        return i;
      }
    }
    return null;
  }

  Widget _buildVideoPlayerWidget(VideoPlayerController controller) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: InkWell(
            onTap: () {
              setState(() {
                controller.value.isPlaying
                    ? controller.pause()
                    : controller.play();
              });
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool isVideoUrl(String url) {
    return url.toLowerCase().endsWith('.mp4');
  }
}
