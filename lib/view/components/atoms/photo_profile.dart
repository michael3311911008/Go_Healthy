import 'package:flutter/material.dart';

class PhotoProfileImage extends StatelessWidget {
  final String? imageUrl;
  final double? minradius;
  final double? maxradius;
  const PhotoProfileImage(
      {Key? key, this.imageUrl, this.minradius, this.maxradius})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: maxradius,
      minRadius: minradius,
      child: imageUrl != null
          ? Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUrl!),
                ),
              ),
            )
          : Icon(Icons.person),
    );
  }
}
