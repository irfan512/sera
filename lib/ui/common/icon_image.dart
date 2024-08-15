import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:sera/extensions/context_extension.dart';

class IconImage extends StatelessWidget {
  final Uri uri;
  final double width;
  final double height;
  final Widget errorWidget;

  const IconImage(
      {required this.uri,
      this.width = 16,
      this.height = 16,
      this.errorWidget = const SizedBox(width: 16, height: 16)});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    return CachedNetworkImage(
        imageUrl: uri.toString(),
        imageBuilder: (_, imageProvider) => Image(
            image: imageProvider,
            width: 16,
            height: 16,
            color: colorScheme.inverseSurface),
        errorWidget: (_, __, ___) => const SizedBox(width: 16, height: 16));
  }
}
