import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SafeSvg extends StatelessWidget {
  final String path;
  final IconData safeIcon;
  final double height;

  const SafeSvg({
    super.key,
    required this.path,
    this.safeIcon = Icons.image_not_supported,
    this.height = 30,
  });

  Future<bool> _exists(BuildContext context) async {
    try {
      await DefaultAssetBundle.of(context).load(path);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _exists(context),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return SvgPicture.asset(path, height: height);
        }
        return Icon(safeIcon, size: height);
      },
    );
  }
}
