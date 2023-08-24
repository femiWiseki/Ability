import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  final ImageProvider<Object>? imageProvider;

  const ProfileImage({required this.imageProvider, Key? key}) : super(key: key);

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  ImageProvider<Object>? _imageProvider;

  @override
  void initState() {
    super.initState();
    _imageProvider = widget.imageProvider;
  }

  void updateImageProvider(ImageProvider<Object>? newImageProvider) {
    setState(() {
      _imageProvider = newImageProvider;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 44,
      backgroundImage: _imageProvider,
    );
  }
}
