import 'package:flutter/material.dart';

class ProfileTab1 extends StatelessWidget {
  const ProfileTab1({super.key});

  @override
  Widget build(BuildContext context) {
    // List of local asset image paths
    List<String> imagePaths = [
      'assets/post1.jpg',
      'assets/post2.jpg',
      'assets/post3.jpg',
      'assets/post4.jpg',
      'assets/post5.jpg',
      'assets/post6.jpg',
      'assets/post7.jpg',
      'assets/post8.jpg',
    ];

    return GridView.builder(
      itemCount: imagePaths.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 images per row
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(1),
          child: Image.asset(
            imagePaths[index],
            fit: BoxFit.cover, // Makes sure the image covers the entire grid space
          ),
        );
      },
    );
  }
}
