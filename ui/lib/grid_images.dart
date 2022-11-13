import 'package:flutter/material.dart';

class GridImages extends StatelessWidget {
  const GridImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Grid Gallery'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(5),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: [
          buildImageItem('assets/burger1.jpg'),
          buildImageItem('assets/burger2.jpg'),
          buildImageItem('assets/burger3.jpg'),
          buildImageItem('assets/burger4.jpg'),
          buildGridTileWithTitle(title: 'Burger 1', imagePath: 'assets/burger1.jpg'),
          buildGridTileWithTitle(title: 'Burger 2', imagePath: 'assets/burger2.jpg'),
          buildGridTileWithTitle(title: 'Burger 3', imagePath: 'assets/burger3.jpg'),
          buildGridTileWithTitle(title: 'Burger 4', imagePath: 'assets/burger4.jpg'),
        ],
      ),
    );
  }

  Widget buildGridTileWithTitle({ required String title, required String imagePath }) {
    return GridTile(
          footer: Material(
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(4),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: GridTileBar(
              title: Text(title),
              backgroundColor: Colors.black54,
            ),
          ),
          child: buildImageItem(imagePath),
        );
  }

  Widget buildImageItem(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image(
        image: AssetImage(imageUrl),
        fit: BoxFit.cover,
      ),
    );
  }
}
