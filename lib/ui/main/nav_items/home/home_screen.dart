import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/common/post_widget.dart';
import 'package:sera/ui/common/story_view.dart';
import 'package:sera/ui/main/main_bloc.dart';
import 'package:sera/ui/main/main_state.dart';
import 'package:sera/ui/product_detail/product_detail_screen.dart';
import 'package:sera/util/base_constants.dart';

final List<Post> postData = [
  Post(
    username: 'Jacob Jones',
    time: 'Just now',
    content:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    imageUrl: 'assets/3x/image2.png',
    buttonText: 'The IT Jumpsuit',
  ),
  Post(
    username: 'Jacob Jones',
    time: 'Just now',
    content: 'Check out our new collection!',
    imageUrl: '',
    buttonText: 'Summer Collection',
  ),
];

class HomeScreen extends StatefulWidget {
  static const String key_title = '/home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    final bloc = context.read<MainScreenBloc>();
    bloc.getAllPostsApi(offset: 0);
    // Add a listener to the scroll controller to detect when the user reaches the end of the list
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Load more data when the user reaches the end
        bloc.getAllPostsApi(offset: bloc.state.homePostsOffset);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final bloc = context.read<MainScreenBloc>();
    final theme = context.theme;
    final size = context.mediaSize;
    return Container(
      height: size.height,
      width: size.width,
      color: const Color(0xfff8f8f7),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(children: [
          BlocBuilder<MainScreenBloc, MainScreenState>(
              builder: (context, state) {
            final data = state.getAllStories;
            if (data is Data) {
              final storiesList = data.data as List<StoryModel>;
              if (storiesList.isNotEmpty) {
                return SizedBox(
                  height: 100,
                  width: size.width,
                  child: ListView.builder(
                      itemCount: storiesList.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StoryView(
                                          story: storiesList[index])));
                            },
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                        "$pictureUrl${storiesList[index].fileUrl}",
                                        height: 100,
                                        width: 140,
                                        fit: BoxFit.cover),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 33,
                                      width: 140,
                                      decoration: BoxDecoration(
                                          color: BaseConstant.homeStoryTileColor
                                              .withOpacity(0.7),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          )),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundImage: NetworkImage(
                                              "$pictureUrl${storiesList[index].appUser!.profileImage!}",
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          storiesList[index].appUser != null
                                              ? Text(
                                                  storiesList[index]
                                                      .appUser!
                                                      .firstName
                                                      .toString(),
                                                  style: theme
                                                      .textTheme.titleLarge!
                                                      .copyWith(
                                                    color: theme
                                                        .colorScheme.secondary,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              : Text(
                                                  "",
                                                  style: theme
                                                      .textTheme.titleLarge!
                                                      .copyWith(
                                                    color: theme
                                                        .colorScheme.secondary,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                          storiesList[index].appUser != null
                                              ? Text(
                                                  storiesList[index]
                                                      .appUser!
                                                      .lastName
                                                      .toString(),
                                                  style: theme
                                                      .textTheme.titleLarge!
                                                      .copyWith(
                                                    color: theme
                                                        .colorScheme.secondary,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              : Text(
                                                  "",
                                                  style: theme
                                                      .textTheme.titleLarge!
                                                      .copyWith(
                                                    color: theme
                                                        .colorScheme.secondary,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return const SizedBox();
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
          BlocBuilder<MainScreenBloc, MainScreenState>(
              builder: (context, state) {
            final data = state.getpostsdata;

            if (data is Loading) {
              return const CircularProgressIndicator();
            } else if (data is Data) {
              final postlist = data.data as List<PostModel>;
              return ListView.builder(
                  itemCount: postlist.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, ProductDetail.route,
                                arguments: postlist[index].productId!);
                          },
                          child: PostWidget(post: postlist[index])),
                    );
                  });
            } else {
              return const SizedBox();
            }
          })
        ]),
      ),
    );
  }
}
